From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Re: Re: should i be able to abort in the middle of
 snd_pcm_mmap_{begin,commit} ?
Date: Thu, 14 Feb 2002 20:12:40 +0200 (EET)
Message-ID: <Pine.LNX.4.44.0202142006470.3739-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.31.0202141856150.510-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 14 Feb 2002, Jaroslav Kysela wrote:

>> What I did try was replacing drop() with snd_pcm_drain() and this resulted
>> in a hang (not a kernel hang, but process never returns to user-space) in
>> the driver level. Here's the backtrace:
> I'm curious what is saying this command:
> cat /proc/asound/card0/pcm0p/sub0/*

Doh, I've totally forgot ALSA's proc entries. Anyways, here's the 
whole dump (status doesn't look good):

--cut--
status:

state: <NULL>
trigger_time: 1013709966.595600
tstamp      : 1013710109.203655
delay       : -6285920
avail       : 6287968
avail_max   : 6287968

hw_params:

access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (1445100000/32768)
period_size: 1024
buffer_size: 2048
tick_time: 10000

sw_params:

tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 1024
xfer_align: 1024
start_threshold: 4294967295
stop_threshold: 4294967295
silence_threshold: 0
silence_size: 0
boundary: 1073741824
--cut--

Status during normal processing (same exact setup):

--cut--
state: RUNNING
trigger_time: 1013710204.382739
tstamp      : 1013710213.136159
delay       : 1040
avail       : 1008
avail_max   : 1040
--cut--

-- 
 http://www.eca.cx
 Audio software for Linux!


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
