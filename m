From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: should i be able to abort in the middle of snd_pcm_mmap_{begin,commit}
 ?
Date: Thu, 14 Feb 2002 15:35:19 +0200 (EET)
Message-ID: <Pine.LNX.4.44.0202141523230.3739-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.44.0202132025530.11029-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: jackit-devel@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>From alsa-devel... 

I've now added a few debugging points to jackd's alsa_driver.c:
	- five checks for xruns in various parts
	  of alsa_driver_wait() (prints an error if xrun
	  is detected; check with snd_pcm_state())
	- prints an error if playback_avail or capture_avail
	  is not 1024 (period size in use)
	- prints a warning everytime alsa_driver_wait()
	  takes more than 25msecs (23.2msec == period time)

In the below test run, audio got garbled when the ecasound
subgraph timed out. To create the timeout I generated lot of cpu and disk 
i/o stress. Few points to note:

- no xruns are detected even though after the timeout
  alsa_driver_wait() took 56.4msec which is more than
  period_size * number_of_periods (1024*2/44100*1000=46msec);
  in other words there should have been an xrun
- after the subgraph timeout I stopped all other heavy 
  processes; for some reason executing 
  alsa_driver_wait() still takes over 25msecs 
  every now and then (-> something happens slower than
  before subgraph timeout)

--cut--
./jackd -r 44100 -p 1024 -d hw:0 -v
jackd 0.11.0
Copyright 2001-2002 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

creating alsa driver ... hw:0|1024|2|44100|swmon
new client: alsa_pcm, type 1 @ 0x8061be0
registered port alsa_pcm:in_1
registered port alsa_pcm:in_2
registered port alsa_pcm:out_1
registered port alsa_pcm:out_2
ALSA: ports registered, starting driver
engine cycle took 26665.111588 usecs
new client: ecasound, type 2 @ 0x4017e000
registered port ecasound:defoutput_1
registered port ecasound:defoutput_2
connect ecasound:defoutput_1 and alsa_pcm:out_1
connect ecasound:defoutput_2 and alsa_pcm:out_2
engine cycle took 25305.427039 usecs
engine cycle took 32327.246781 usecs
engine cycle took 31287.197425 usecs
engine cycle took 26726.896996 usecs
engine cycle took 25433.017167 usecs
engine cycle took 25630.954936 usecs
engine cycle took 25678.708155 usecs
engine cycle took 29338.167382 usecs
engine cycle took 25405.414163 usecs
engine cycle took 31867.433476 usecs
engine cycle took 26505.763948 usecs
engine cycle took 25985.703863 usecs
engine cycle took 25095.143777 usecs
engine cycle took 25036.152361 usecs
engine cycle took 27495.572961 usecs
engine cycle took 28867.422747 usecs
subgraph starting at ecasound timed out (state = 2)
client ecasound state = 2
removing failed client ecasound
removing client ecasound
DIS-connect ecasound:defoutput_2 and alsa_pcm:out_2
DIS-connect ecasound:defoutput_1 and alsa_pcm:out_1
client alsa_pcm state = 0
engine cycle took 56401.128755 usecs
i/o error on unknown client fd 31
new client: ecasound, type 2 @ 0x4017e000
registered port ecasound:defoutput_1
registered port ecasound:defoutput_2
engine cycle took 40472.100858 usecs
connect ecasound:defoutput_1 and alsa_pcm:out_1
connect ecasound:defoutput_2 and alsa_pcm:out_2
engine cycle took 36322.628755 usecs
engine cycle took 30340.630901 usecs
engine cycle took 27335.261803 usecs
engine cycle took 25912.163090 usecs
engine cycle took 32502.793991 usecs
engine cycle took 27490.444206 usecs
engine cycle took 25834.858369 usecs
engine cycle took 25207.817597 usecs
engine cycle took 26574.560086 usecs
engine cycle took 29626.800429 usecs
engine cycle took 29376.212446 usecs
engine cycle took 27592.478541 usecs
engine cycle took 25239.598712 usecs
engine cycle took 26443.122318 usecs
engine cycle took 25291.517167 usecs
engine cycle took 25615.218884 usecs
engine cycle took 27318.682403 usecs
engine cycle took 44521.978541 usecs
engine cycle took 25640.030043 usecs
engine cycle took 25367.130901 usecs
engine cycle took 26560.156652 usecs
alsa_pcm: xrun of 2160 frames, (48.980 msecs)
engine cycle took 28737.905579 usecs
engine cycle took 25025.935622 usecs
engine cycle took 35878.388412 usecs
engine cycle took 39361.665236 usecs
engine cycle took 25087.163090 usecs
engine cycle took 29457.489270 usecs
engine cycle took 38277.605150 usecs
engine cycle took 25026.238197 usecs
engine cycle took 25052.620172 usecs
engine cycle took 25057.508584 usecs
engine cycle took 25170.804721 usecs
engine cycle took 25704.386266 usecs
DIS-connect ecasound:defoutput_1 and alsa_pcm:out_1
DIS-connect ecasound:defoutput_2 and alsa_pcm:out_2
removing client ecasound
engine cycle took 28678.154506 usecs
--cut--

On Thu, 14 Feb 2002, Kai Vehmanen wrote:

> On Wed, 13 Feb 2002, Paul Davis wrote:
> 
> [xrun after mmap_begin]
> > after restarting, the audio stream is not in sync - it contains minor
> > crackles and clicks suggesting that the device driver doesn't really
> > know where the hw pointer is. the effect varies with the period size,
> > which reinforces my belief in what's gone wrong. this happens on both
> > the hammerfall and the trident, though the effect sounds a little
> 
> I've noticed similar problems with CVS versions of ALSA and JACK. My
> card is ens1371. The crackled audio doesn't occur every time, but 
> practically always after a subgraph timeouts. The sound is mostly ok 
> (stereo image is fine, rate is correct, also amplitude), but it's 
> badly garbled (for lack of a better adjective).
> 
> Hmm, it could be that committed periods overlap in hw mem, or are shorter
> than longer than what hw excepts (-> gaps between committed periods). 
> 
> 

-- 
 http://www.eca.cx
 Audio software for Linux!


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
