From: Tim <terminator356@users.sourceforge.net>
Subject: Re: Need help: My .asoundrc no longer works.
Date: Fri, 26 Jan 2007 01:28:31 +0000 (UTC)
Message-ID: <loom.20070126T022638-883@post.gmane.org>
References: <loom.20070120T001557-202@post.gmane.org>
	<s5hbqkrf96d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai <at> suse.de> writes:
> It's way too old to debug...  Please try the latest version,
> 1.0.14rc2, at first.

I installed alsa 1.0.14rc2, but now the situation is worse.
Now multi refuses to work at all no matter what I try in
 .asoundrc
Remember: I have an emu10k1 based card, which can only
 use 8 or 16 bits, and an ice1712 based card, which can
 only use 32 bits. Therefore I need a plug converter on
 one or both of the slaves.

I did some tests, and it seems that multi does not like
 the plug converter. The plug converter by itself seems to 
 work OK. Examples:

If I just do a simple plug conversion on either card alone like this:
 arecord -c12 -r 48000 -f U8 -Dplughw:1,0 test.wav
or
 arecord -c8 -r 48000 -f U8 -Dplughw:0,2 test.wav
it works.

However if I do a simple multi with only ONE slave:

.asoundrc:
  pcm.ice1712 { type hw; card 1; }
  pcm_slave.sl3 { pcm ice1712 }
  pcm.ice1712_convert { type plug; slave sl3; }
  pcm.multi_rec {
                 type multi
                 slaves.a.pcm ice1712_convert
                 slaves.a.channels 12
                 bindings.0.slave a;
                 bindings.0.channel 0;
                 bindings.1.slave a;
                 bindings.1.channel 1;
                 etc. (twelve bindings...) 
                }
 then
arecord -c12 -r 48000 -f U8 -Dmulti_rec test.wav
 fails with:
ALSA lib pcm_mmap.c:141:(snd_pcm_mmap_read_areas) too short avail 0 to size 
1365
If I use the --avail-min option, then no matter how high a value I set,
 arecord just spews out x-runs forever, even with the -d option set at 1, for 
ex.

But if I do this:
arecord -c12 -r 48000 -f S32_LE -Dmulti_rec test.wav
 then it works.
I get similar results if I use the emu10k1 card instead of the ice1712,
 except that it only likes S16_LE or U8.
So it seems multi does not accept plug conversion of anything 
 other than the native format (S32_LE for ice1712, S16_LE or U8 for emu10k1).
So therefore when I combine BOTH cards into one multi, then multi
 really falls down. No combination of plug values, or the order of the
 two slaves, works.

Note that all of this worked OK under alsa-1.0.9, and as I mentioned before,
 APPEARS to work under alsa-1.0.12 - but does not actually record any sound
 from the multi second slave.
Under alsa-1.0.12 I saw that arecord told me alsa lib could not IOCTL LINK
 or UNLINK the two cards. But this seems to be gone now, under alsa-1.0.14rc2.

>From that, I can see that the alsa team is working hard on this, but I
 wonder if we are regressing - getting worse...
Hope this helps you.

---------------------------------
There is one more important issue:
What happened to all the input gain controls (IPGA) in the ice1712 driver?
With alsa-1.0.14rc2 they are gone! They don't show up in envy24control,
 or any other mixer I try which shows ALL alsa controls.
If this is an attempt to unify the IPGA and ADC controls, I agree. Carry on.
Anyone who has used the envy24control knows it is a bit strange.
If you operate the ADC controls, the IPGA controls are forced to zero,
 likewise if you operate the IPGA controls, the ADC controls are forced
 to max. Unification of the two controls would make a lot of sense.
But I could not seem to get them to work properly with this alsa-1.0.14rc2

Thanks. Any suggestions or feedback appreciated.
I will happily test anything you throw at me... 
Tim.




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
