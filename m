From: Tim <terminator356@users.sourceforge.net>
Subject: Need help: My .asoundrc no longer works.
Date: Sat, 20 Jan 2007 00:39:20 +0000 (UTC)
Message-ID: <loom.20070120T001557-202@post.gmane.org>
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

Thanks for the emu patch! Works ok now.

Now I have a problem I reeeeeally need help with.
I have an SBLive! (emu10k1) as card 0 and an 
 M-audio Delta1010LT (ice1712) as card 1.
With alsa-1.0.9 the following .asoundrc files worked OK.

But now I've installed Mandriva2007 (alsa-1.0.12).
What happens now is this: QJackCtl presents me with 
 16 inputs, as before, but only the lower eight emu10k1 
 ones give me any audio. I get no audio by connecting 
 any of the upper eight ice1712 inputs to ANY of the 
 (twelve hw:1,0) outputs.
If I reverse the order of the cards in .asoundrc - see below,
 (ie lower eight inputs ice1712, upper eight emu10k1),
 then STILL only the LOWER eight QJackCtl inputs work -
 which are the ice1712 inputs !

But if I interleave the inputs - see third .asoundrc below,
 (ie one emu input, then one ice input, then one emu etc.),
 strangely only the emu inputs work, not the ice inputs !

Note the single use of a plug converter. This is the only way
 I can make them work, converting the emu but not the ice gives 
 'no playback configs avail', and converting both emu and ice gives
 ALSA: could not complete read of 0 frames: error = -32
 cycle execution failure, exiting
 DRIVER NT: could not run driver cycle.

At first I though maybe a pcm multi problem. 
I looked at changes to pcm_multi.c, not much change there, but I 'reverted'
 a couple of things back to 1.0.9 state, but it didn't fix the problem.

Anyway, since the problem is always with the 'b' slave,
 and since the 'b' slave always needs a converter, I'm wondering
 if there's a problem with the 'plug' converter itself (or my plug sections).

Any help much appreciated! Thanks. 
I hope this can be fixed - many hours I've just spent, getting
 this new distro (fixed) up - only to reach this conclusion now!
Cheers. Tim. 


----------------------------------------------------
Original .asoundrc with emu10k1 ahead of ice1712:
----------------------------------------------------
pcm.ice1712 {
              type hw
              card 1
            }

pcm_slave.sl3 {
    pcm ice1712
}

pcm.ice1712_convert {
    type plug
    slave sl3
}

pcm.multi_rec {
            type multi;
            slaves.a.pcm "hw:0,2";
            slaves.a.channels 16;
            slaves.b.pcm ice1712_convert;
            slaves.b.channels 8;
            
            # Some SBLive! inputs.
            # Customized emu10k1 driver gives me EIGHT seperate
            #  MIDI SoundFont audio inputs, rather than just
            #  combining them ALL on TWO FX lines !!!
            # Ask me, if you're wondering about this.
            # I may ask YOU later to include this feature in alsa !
            bindings.0.slave a;
            bindings.0.channel 10;
            bindings.1.slave a;
            bindings.1.channel 11;
            bindings.2.slave a;
            bindings.2.channel 12;
            bindings.3.slave a;
            bindings.3.channel 13;
            
            bindings.4.slave a;
            bindings.4.channel 14;
            bindings.5.slave a;
            bindings.5.channel 15;
            bindings.6.slave a;
            bindings.6.channel 0;
            bindings.7.slave a;
            bindings.7.channel 1;
            
            #
            # M-audio delta1010LT
            #
            bindings.8.slave b;
            bindings.8.channel 0;
            bindings.9.slave b;
            bindings.9.channel 1;
            bindings.10.slave b;
            bindings.10.channel 2;
            bindings.11.slave b;
            bindings.11.channel 3;
          
            bindings.12.slave b;
            bindings.12.channel 4;
            bindings.13.slave b;
            bindings.13.channel 5;
            bindings.14.slave b;
            bindings.14.channel 6;
            bindings.15.slave b;
            bindings.15.channel 7;
          }

ctl.multi_rec {
            type hw;
            card 0;
          }



-----------------------------------------------
.asoundrc with ice1712 ahead of emu10k1
-----------------------------------------------
pcm.emu10k1_multi_rec {
              type hw
              card 0
              device 2
            }

pcm_slave.sl2 {
    pcm emu10k1_multi_rec
}

pcm.emu10k1_convert_rec {
    type plug
    slave sl2
}

pcm.multi_rec {
            type multi;
            slaves.a.pcm "hw:1,0";
            slaves.a.channels 8;
            slaves.b.pcm emu10k1_convert_rec;
            slaves.b.channels 16;
            
            #
            # M-audio delta1010LT
            #
            bindings.0.slave a;
            bindings.0.channel 0;
            bindings.1.slave a;
            bindings.1.channel 1;
            bindings.2.slave a;
            bindings.2.channel 2;
            bindings.3.slave a;
            bindings.3.channel 3;
          
            bindings.4.slave a;
            bindings.4.channel 4;
            bindings.5.slave a;
            bindings.5.channel 5;
            bindings.6.slave a;
            bindings.6.channel 6;
            bindings.7.slave a;
            bindings.7.channel 7;
            
            # Eight SBLive! inputs. See comments in the other .asoundrc
            bindings.8.slave b;
            bindings.8.channel 10;
            bindings.9.slave b;
            bindings.9.channel 11;
            bindings.10.slave b;
            bindings.10.channel 12;
            bindings.11.slave b;
            bindings.11.channel 13;
            
            bindings.12.slave b;
            bindings.12.channel 14;
            bindings.13.slave b;
            bindings.13.channel 15;
            bindings.14.slave b;
            bindings.14.channel 0;
            bindings.15.slave b;
            bindings.15.channel 1;
          }

ctl.multi_rec {
            type hw;
            card 0;
          }



------------------------------------------------------
.asoundrc with emu10k1 interleaved with ice1712:
------------------------------------------------------
pcm.ice1712 {
              type hw
              card 1
            }

pcm_slave.sl3 {
    pcm ice1712
}

pcm.ice1712_convert {
    type plug
    slave sl3
}

pcm.multi_rec {
            type multi;
            slaves.a.pcm "hw:0,2";
            slaves.a.channels 16;
            slaves.b.pcm ice1712_convert;
            slaves.b.channels 8;
            
            # Interleaved SBLive! and Delta1010LT inputs.
            #
            bindings.0.slave a;
            bindings.0.channel 10;
            bindings.1.slave b;
            bindings.1.channel 0;
            bindings.2.slave a;
            bindings.2.channel 11;
            bindings.3.slave b;
            bindings.3.channel 1;
            
            bindings.4.slave a;
            bindings.4.channel 12;
            bindings.5.slave b;
            bindings.5.channel 2;
            bindings.6.slave a;
            bindings.6.channel 13;
            bindings.7.slave b;
            bindings.7.channel 3;
            
            bindings.8.slave a;
            bindings.8.channel 14;
            bindings.9.slave b;
            bindings.9.channel 4;
            bindings.10.slave a;
            bindings.10.channel 15;
            bindings.11.slave b;
            bindings.11.channel 5;
          
            bindings.12.slave a;
            bindings.12.channel 0;
            bindings.13.slave b;
            bindings.13.channel 6;
            bindings.14.slave a;
            bindings.14.channel 1;
            bindings.15.slave b;
            bindings.15.channel 7;
          }

ctl.multi_rec {
            type hw;
            card 0;
          }



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
