From: Joshua Haberman <joshua@haberman.com>
Subject: Re: PCM API questions
Date: Mon, 24 Jun 2002 23:04:25 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020625060425.GA15056@reverberate.org>
References: <200206242113.g5OLDAf25236@post2.fast.net> <Pine.LNX.4.33.0206250310090.616-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0206250310090.616-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

* Jaroslav Kysela (perex@suse.cz) wrote:
> On Mon, 24 Jun 2002, Paul Davis wrote:
> 
> > >Maybe this is what the "default" device is intended for, but can it
> > >accommodate more than one card?  I happen to have a sound card built into
> > >my motherboard and another in a PCI slot -- how do I tell XMMS which one
> > >to use?
> > 
> > an excellent context for the question. 
> > 
> > i want to extend the question just a little. it seems from watching a
> > few friends who use windows audio apps that its conventional there to
> > name audio output options after the physical hardware. so you see
> > things like "Terratec XWP" and "Ensoniq PCM" and so forth. This is
> > nice because its what a lot of users think in terms of.
> > 
> > in ALSA, we really don't see such naming at all. thats fine with me,
> > but it leads me to wonder. the reason that the names are useful is
> > that they don't move around when you change the install order for the
> > modules (for example). so, the "Ensoniq PCM" is always the "Ensoniq
> > PCM" whether its the first card or the second.
> > 
> > Now, AFAICT, Windows doesn't make it very easy to deal with multiple
> > "Ensoniq PCM" devices whereas ALSA does. However, there does seem to
> > be something "missing" when we present users with
> > 
> >    plughw:1,0
> > 
> > as the name of suitably flexible device for general purpose audio on
> > the second card in the absence of a ~/.asoundrc file ....
> > 
> > So I'm left wondering what naming scheme to use to get a more flexible
> > way of referring to cards *without* using an ~/.asoundrc
> > file. Alternatively, how to autogenerate the file so that it provides
> > nice names?
> 
> I think that you've forgot that we can identify hardware devices over the 
> control interface. Look for snd_ctl_pcm_next_device() and snd_ctl_pcm_info()
> functions. It's easy to use this information with combination of PCM names 
> like 'hw:CARD,DEVICE,SUBDEVICE' and 'plughw:*'.

I didn't know about these functions.  Here is what I came up with:

joshua@birdie:~/code$ cat alsa_devices.c 

#include <alsa/asoundlib.h>

int main() {
    snd_ctl_t *ctl;
    snd_pcm_info_t *info;
    char *cardname;
    char alsaname[100];
    char *devicename;
    int device;
    int card_idx = -1;
    int device_idx;

    snd_pcm_info_malloc(&info);

    while( snd_card_next(&card_idx) == 0 && card_idx >= 0 ) {
        snd_card_get_name(card_idx, &cardname);
        printf("card %d: %s\n", card_idx, cardname);

        device_idx = -1;
        sprintf(alsaname, "hw:%d", card_idx);
        snd_ctl_open(&ctl, alsaname, 0);
        while( snd_ctl_pcm_next_device(ctl, &device_idx) == 0  && device_idx >= 0 ) {
            snd_ctl_pcm_info(ctl, info);
            devicename = snd_pcm_info_get_name(info);
            printf("\tdevice %d: %s\n", device_idx, devicename);
        }
    }
}
joshua@birdie:~/code$ ./alsa_devices 
card 0: Sound Blaster Live!
        device 0: EMU10K1
        device 1: EMU10K1
        device 2: EMU10K1
        device 3: EMU10K1
card 1: SiS SI7012
        device 0: SiS SI7012

This is useful (though the subdevice names provide no information).
Using a process similar to this, it would be easy to write a program like
this:

foreach card:
    tell the user "I discovered a card named $card"
    if the user has more than one card named this, emit a beep to disambiguate
    ask the user what to call this card
    add to ~/.asoundrc: "pcm.$users_name { type hw  card $num }"

But this leaves two problems:
    1. ~/.asoundrc becomes invalid if drivers are loaded in a different order
    2. How can applications get a list of the cards the user defined?

What would be even nicer is if the symbolic names above ("Sound Blaster
Live!" and "SiS SI7012" could be automatically aliased to the hw:$x:0
entries, so that an application could call:

    snd_pcm_open( "Sound Blaster Live!", SND_PCM_STREAM_PLAYBACK, 0 );

and get the right thing.

Josh


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
