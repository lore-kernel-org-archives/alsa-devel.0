From: =?iso-8859-15?q?Z=E9bulon?= <zeb@zebulon.org.uk>
Subject: Some remarks/bugs/question about M-audio Revolution (ice1724)
Date: Wed, 7 May 2003 21:54:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305072154.27740.zeb@zebulon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I could make a Revolution card work under Mandrake 9.1, after recompiling the 
alsa-drivers. Then loading snd-ice1724 did the job and sound is excellent, 
compared to my old SB Live Value... Just a regret : no CD audio connector, so 
I have to play CDs with digital extraction with cdda2wav, and it consumes 
some CPU and blocks IDE port. Moreover, this is a pain with KDE which blocks 
/dev/dsp with artsd. The problem is if I kill artsd, I cannot use some KDE 
applications.

Some remarks though :

- the sound sometimes cracks with some DVDs
- xine-alsa crashes, I need to use oss driver in xine (probably through 
snd-pcm-oss), but not directly the alsa drivers. Then no multichannel could 
be used.
- I had to use alsamixer to change the levels (normal). However, I use a TV 
card, connected to line In. If I want to listen to oggvorbis file through 
xmms alsa, I had to set H/W 1 and H/W 2 to PCM Out, however, to listen to tv 
sound, it was H/W In 0
- maybe a bug : If I set the Multi Track Internal Clock to IEC958, I cannot 
change the setting anymore.

So my question is : are those bugs, limitations of a young driver, or 
limitations in the card architecture ? Should we expect a better support in 
the future ? My old SBLive sounds crap compared to this, but I could play 
CDs, watch TV, or play oggvorbis files without changing the settings IN/OUT 
in alsamixer.

Thanks


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
