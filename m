From: lamikr <lamikr@cc.jyu.fi>
Subject: How to select between mixer route elements?
Date: Tue, 02 May 2006 01:06:00 +0300
Message-ID: <44568648.9040902@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi

I am working with the tsc2101 alsa sound driver for the iPAQ h6300 and
userspace phone application called gomunicator for that.
For the tsc2101 mixer I have creted an element "Playback Playback Route"
which is currently initalized to be a enumerated element
in a following way.

    static char *texts[PLAYBACK_TARGET_COUNT] = {
            "Loudspeaker", "Headphone", "Cellphone"
    };
    uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;

The idea is following. If I/user want to play music or record by using
normal speaker and mic I need to select "Loudspeaker"
as a playback target. If I instead want to use headphone for that
purpose I need to select Headphone. And when I want to have a phone call
(this iPAQ module has gsm phone) I route tsc2101 to handle gsm module by
selecting "Cellphone".

The problem is that currently I need to use alsa-mixer before I make the
phone calls which is kind of not very handy.
So to get Tux finally a call home properly I should do something like
this from the userspace:

    old_selection    = get_current_playback_route_selection(),
    select_playback_route("Cellphone");
    make_call()
    end_call()
    select_playback_route(old_selection)

To implement the currently selected route item, I have tried following

    static int *old_playback_item;
    ...
    snd_mixer_selem_id_set_name (sid, "Playback");
    if (elem_playback) {
        printf("Playback found\n");
        if (snd_mixer_selem_is_enumerated(elem_playback)) {
            printf("Playback is enumerated\n");
            //snd_mixer_selem_get_enum_item(handle, 0, old_playback_item);
            printf("index fo the selected playback item = %d\n",
*old_playback_item);
        }
    }

but this fails for me giving a following error to output:

    Playback found
    Playback is enumerated
    gomunicator: simple.c:1969: snd_mixer_selem_get_enum_item: Assertion
`elem->type == SND_MIXER_ELEM_SIMPLE' failed.

Could somebody show how to do that in the alsa-lib? (I have not been
able to find any documentation/examples how to handle alsa route
elements when I tried to search from the net)

Mika



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
