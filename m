From: "Ed Wildgoose" <Ed@Wildgooses.com>
Subject: Jack-Alsa plugin - problems (does it work at all?!)
Date: Wed, 7 Jan 2004 14:21:50 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <00e901c3d529$97d63840$5d40a8c0@FRiskMan.com>
References: <04de01c3d37f$20a3aa10$5d40a8c0@FRiskMan.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



> Hi, I'm having some problems getting the alsa input into Jack working
> correctly.
>
> The soundcard is an RME96/8 PAD, Alsa from Kernel 2.6 pre9, and Jack
version
> 0.91.1 - I'm firing up Jackd with:
>
> jackd -R -t 2000 -d alsa -d rme96 -r 44100 -p 1024 -n 8 -m -zs -H -M &
>
> ...and I have an asound config (below) which lets me play sounds correctly
> with something like: aplay -D jackplug blah.wav
>
> However, trying to use either xmms, mplayer or mythtv with the same alsa
> device just seems to leave the app "hanging" and not doing anything, and
> attempts to fastforward in mplayer and mythtv (which presumably causes the
> alsa layer in each app to try and pause then reopen the sound layer)
causes
> the error:
>
> "You cannot set callbacks on an active client
> cannot connect alsaP:out_000
>  to alsa_pcm:playback_1"
>
> No sound comes out...
>
> Is this an alsa issue, sound card driver problem or something else?  Apart
> from aplay (which does work) are there any other things I should try to
test
> the alsa-jack plugin?  Just for reference at least some native jack apps
> seem to be working fine, although I haven't tried the xmms-jack plugin
yet.
>
> Can anyone please help with some debugging ideas here.  I'm really keen to
> get Jack working as it seems to be the best way to integrate Brutefir in
> order to do some fancy room correction effects (note: Brutefir is not
active
> in the failed tests above, just to remove some variables...)
>

I've still not got this working *at all*.  I have switched in a new RME 9632
card to compare, and upgraded the drivers on my 2.6.1mm2 kernel to the
latest tarball 1.0rc2 versions.

Still the same issue.  Every app just sits there hanging or making no sound
when you ask it to play to the jackplug pcm device.  Most recently I
installed alsaplayer and the same happens here - it's own native jack output
layer works a treat, but the alsa output to the jack output just plays
silence (although it doesn't seem to hang the app now...)

I did spot one problem in that I hadn't created a ctl device for my pcm
originally, but my new asoundrc is below and this doesn't play anything...

Does someone have this working *at all* on their system? Could you please
demonstrate your asoundrc and list your soundcard make/model and versions of
drivers.

Thanks

        pcm.rme96 {
                type hw
                card 0
        }

        ctl.rme96 {
                type hw
                card 0
        }

        pcm.jackplug {
                type plug
                slave { pcm "jack" }
        }

        ctl.jackplug {
                type hw
                card 0
        }

        pcm.jack {
                type jack
                playback_ports {
                       0 alsa_pcm:playback_1
                       1 alsa_pcm:playback_2
                }
                       capture_ports {
                       0 alsa_pcm:capture_1
                       1 alsa_pcm:capture_2
               }
        }

        ctl.jack {
                type hw
                card 0
        }



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
