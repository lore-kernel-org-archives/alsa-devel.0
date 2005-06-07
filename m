From: Jeremy White <jwhite@codeweavers.com>
Subject: RFC:  Appropriate device detection for Wine
Date: Mon, 06 Jun 2005 22:52:09 -0500
Message-ID: <42A519E9.2000103@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040809070409080903030403"
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
Cc: Robert Reif <reif@earthlink.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040809070409080903030403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

I was hoping to get some advice on the proper use of Alsalib
within Wine, particularly with respect to
device detection and enumeration.

Wine has a need to provide a list of all available
PCM (playback and capture) devices back to our
clients (a Windows program).

Right now, Wine has a brute force
scan process (iterate 0-5 in cards, always use dev 0).

I've implemented a program that represents what I think
is the 'right' way for Wine to perform this scan.
Note that this code is just for the default case where
the user hasn't explicitly specified a device
name; Wine will still allow the user to override this
scan with an explicit device name such as file:/tmp/blat

The basic approach I take is as follows:
   Use snd_card_next to iterate cards;
within cards, use snd_ctl_pcm_next_device
to iterate devices.

I jump through a few hoops to detect and respect
a specification of ALSA_CTL_CARD or ALSA_CARD, etc,

Now I've deluded myself into thinking this is a
careful, rigorous implementation.

Thoughts?  Comments?  Tactfully worded puncturing of
my delusions <grin>?

Thanks,

Jeremy

--------------040809070409080903030403
Content-Type: text/x-csrc;
 name="alsascan.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsascan.c"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <alsa/asoundlib.h>

/* Macros to mock up Wine compatibility */
#define ERR printf
#define WARN printf
#define TRACE printf
#define TRUE 1
#define FALSE 0

#define ALSA_RETURN_ONFAIL(mycall)                                      \
{                                                                       \
    int rc = mycall;                                                    \
    if ((rc) < 0)                                                       \
    {                                                                   \
        ERR("%s failed:  %s(%d)\n", #mycall, snd_strerror(rc), rc);     \
        return(rc);                                                     \
    }                                                                   \
}

/*----------------------------------------------------------------------------
**  ALSA_AddPlaybackDevice
**
**      Add a given Alsa device to Wine's internal list of Playback
**  devices.
**
**  Parameters:
**      ctl         Control handle; can be NULL
**      pcm         PCM handle, must be ! NULL
**      isdefault   Flag, if !0, indicates this device matches Alsa's
**                  definition of the default PCM device
**
**--------------------------------------------------------------------------*/
static int ALSA_AddPlaybackDevice(snd_ctl_t *ctl, snd_pcm_t *pcm, int isdefault)
{
    snd_pcm_info_t *infop;

    ALSA_RETURN_ONFAIL(snd_pcm_info_malloc(&infop));
    ALSA_RETURN_ONFAIL(snd_pcm_info(pcm, infop));

    /* FIXME:  Add real implementation here */
    printf("Playback [pcm %s/ctl %s|id %s|", snd_pcm_name(pcm), ctl ? snd_ctl_name(ctl) : "(none)", snd_pcm_info_get_id(infop));
    printf("name %s|%s", snd_pcm_info_get_name(infop), isdefault ? "Default" : "Not default");
    printf("]\n");

    snd_pcm_info_free(infop);

    return 0;
}

/*----------------------------------------------------------------------------
**  ALSA_AddCaptureDevice
**
**      Add a given Alsa device to Wine's internal list of Capture
**  devices.
**
**  Parameters:
**      ctl         Control handle; can be NULL
**      pcm         PCM handle, must be ! NULL
**      isdefault   Flag, if !0, indicates this device matches Alsa's
**                  definition of the default PCM device
**
**--------------------------------------------------------------------------*/
static int ALSA_AddCaptureDevice(snd_ctl_t *ctl, snd_pcm_t *pcm, int isdefault)
{
    snd_pcm_info_t *infop;

    ALSA_RETURN_ONFAIL(snd_pcm_info_malloc(&infop));
    ALSA_RETURN_ONFAIL(snd_pcm_info(pcm, infop));

    /* FIXME:  Add real implementation here */
    printf("Capture  [pcm %s/ctl %s|id %s|", snd_pcm_name(pcm), ctl ? snd_ctl_name(ctl) : "(none)", snd_pcm_info_get_id(infop));
    printf("name %s|%s", snd_pcm_info_get_name(infop), isdefault ? "Default" : "Not default");
    printf("]\n");

    snd_pcm_info_free(infop);

    return 0;
}

/*----------------------------------------------------------------------------
**  ALSA_CheckEnvironment
**
**      Given an Alsa style configuration node, scan its subitems
**  for environment variable names, and use them to find an override,
**  if appropriate.
**      This is essentially a long and convolunted way of doing:
**          getenv("ALSA_CARD") 
**          getenv("ALSA_CTL_CARD") 
**          getenv("ALSA_PCM_CARD") 
**          getenv("ALSA_PCM_DEVICE") 
**
**  The output value is set with the atoi() of the first environment
**  variable found to be set.
**--------------------------------------------------------------------------*/
static void ALSA_CheckEnvironment(snd_config_t *node, int *outvalue)
{
    snd_config_iterator_t iter;

    for (iter = snd_config_iterator_first(node); 
         iter != snd_config_iterator_end(node);
         iter = snd_config_iterator_next(iter))
    {
        snd_config_t *leaf = snd_config_iterator_entry(iter);
        if (snd_config_get_type(leaf) == SND_CONFIG_TYPE_STRING)
        {
            const char *value;
            if (snd_config_get_string(leaf, &value) >= 0)
            {
                char *p = getenv(value);
                if (p)
                {
                    *outvalue = atoi(p);
                    return;
                }
            }
        }
    }
}

/*----------------------------------------------------------------------------
**  ALSA_DefaultDevices
**
**      Jump through Alsa style hoops to (hopefully) properly determine
**  Alsa defaults for CTL Card #, as well as for PCM Card + Device #.
**  We'll also find out if the user has set any of the environment
**  variables that specify we're to use a specific card or device.
**
**  Parameters:
**      plugflag        Whether to use the plugin device or not;
**                      essentially switches the pcm device name from
**                      "hw" to "plughw".
**      defctlcard      If !NULL, will hold the ctl card number given
**                      by the ALSA config as the default
**      defpcmcard      If !NULL, default pcm card #
**      defpcmdev       If !NULL, default pcm device #
**      fixedctlcard    If !NULL, and the user set the appropriate
**                          environment variable, we'll set to the
**                          card the user specified.
**      fixedpcmcard    If !NULL, and the user set the appropriate
**                          environment variable, we'll set to the
**                          card the user specified.
**      fixedpcmdev     If !NULL, and the user set the appropriate
**                          environment variable, we'll set to the
**                          device the user specified.
**
**  Returns:  0 on success, < 0 on failiure
**--------------------------------------------------------------------------*/
static int ALSA_DefaultDevices(int plugflag, 
            long *defctlcard,
            long *defpcmcard, long *defpcmdev,
            int *fixedctlcard, 
            int *fixedpcmcard, int *fixedpcmdev)
{
    snd_config_t   *configp;
    char pcmsearch[256];

    ALSA_RETURN_ONFAIL(snd_config_update());

    if (defctlcard)
        if (snd_config_search(snd_config, "defaults.ctl.card", &configp) >= 0)
            snd_config_get_integer(configp, defctlcard);

    if (defpcmcard)
        if (snd_config_search(snd_config, "defaults.pcm.card", &configp) >= 0)
            snd_config_get_integer(configp, defpcmcard);

    if (defpcmdev)
        if (snd_config_search(snd_config, "defaults.pcm.device", &configp) >= 0)
            snd_config_get_integer(configp, defpcmdev);


    if (fixedctlcard)
    {
        if (snd_config_search(snd_config, "ctl.hw.@args.CARD.default.vars", &configp) >= 0)
            ALSA_CheckEnvironment(configp, fixedctlcard);
    }

    if (fixedpcmcard)
    {
        sprintf(pcmsearch, "pcm.%s.@args.CARD.default.vars", plugflag ? "plughw" : "hw");
        if (snd_config_search(snd_config, pcmsearch, &configp) >= 0)
            ALSA_CheckEnvironment(configp, fixedpcmcard);
    }

    if (fixedpcmdev)
    {
        sprintf(pcmsearch, "pcm.%s.@args.DEV.default.vars", plugflag ? "plughw" : "hw");
        if (snd_config_search(snd_config, pcmsearch, &configp) >= 0)
            ALSA_CheckEnvironment(configp, fixedpcmdev);
    }

    return 0;
}


/*----------------------------------------------------------------------------
**  ALSA_ScanDevices
**
**      Iterate through all discoverable ALSA cards, searching
**  for usable PCM devices.
**
**  Parameters:
**      plugflag        Whether to use the plugin device or not;
**                      essentially switches the pcm device name from
**                      "hw" to "plughw".
**      defctlcard      Alsa's notion of the default ctl card.
**      defpcmcard         . pcm card 
**      defpcmdev          . pcm device 
**      fixedctlcard    If not -1, then gives the value of ALSA_CTL_CARD
**                          or equivalent environment variable
**      fixedpcmcard    If not -1, then gives the value of ALSA_PCM_CARD
**                          or equivalent environment variable
**      fixedpcmdev     If not -1, then gives the value of ALSA_PCM_DEVICE
**                          or equivalent environment variable
**
**  Returns:  0 on success, < 0 on failiure
**--------------------------------------------------------------------------*/
static int ALSA_ScanDevices(int plugflag, 
        long defctlcard, long defpcmcard, long defpcmdev,
        int fixedctlcard, int fixedpcmcard, int fixedpcmdev)
{
    int card = fixedpcmcard;

    /*------------------------------------------------------------------------
    ** Loop through all available cards
    **----------------------------------------------------------------------*/
    if (card == -1)
        snd_card_next(&card);

    for (; card != -1; snd_card_next(&card))
    {
        char ctlname[256];
        snd_ctl_t *ctl;
        int rc;
        int device;

        /*--------------------------------------------------------------------
        ** Try to open a ctl handle; Wine doesn't absolutely require one,
        **  but it does allow for volume control and for device scanning
        **------------------------------------------------------------------*/
        sprintf(ctlname, "hw:%d", fixedctlcard == -1 ? card : fixedctlcard);
        rc = snd_ctl_open(&ctl, ctlname, 0);
        if (rc < 0)
        {
            ctl = NULL;
            WARN("Unable to open an alsa ctl for [%s] (pcm card %d): %s; not scanning devices\n", 
                    ctlname, card, snd_strerror(rc));
            if (fixedpcmdev == -1)
                fixedpcmdev = 0;
        }

        /*--------------------------------------------------------------------
        ** Loop through all available devices on this card
        **------------------------------------------------------------------*/
        device = fixedpcmdev;
        if (device == -1)
            snd_ctl_pcm_next_device(ctl, &device);

        for (; device != -1; snd_ctl_pcm_next_device(ctl, &device))
        {
            char pcmname[256];
            snd_pcm_t *pcm;

            /*----------------------------------------------------------------
            ** See if it's a valid playback device 
            **--------------------------------------------------------------*/
            sprintf(pcmname, "%s:%d,%d", plugflag ? "plughw" : "hw", card, device);
            rc = snd_pcm_open(&pcm, pcmname, SND_PCM_STREAM_PLAYBACK, 0);
            if (rc >= 0)
            {
                if (defctlcard == card && defpcmcard == card && defpcmdev == device)
                    ALSA_AddPlaybackDevice(ctl, pcm, TRUE);
                else
                    ALSA_AddPlaybackDevice(ctl, pcm, FALSE);

                snd_pcm_close(pcm);
            }
            else
            {
                TRACE("Device [%s] not suitable for playback: %s\n",
                        pcmname, snd_strerror(rc));
            }

            /*----------------------------------------------------------------
            ** See if it's a valid capture device 
            **--------------------------------------------------------------*/
            rc = snd_pcm_open(&pcm, pcmname, SND_PCM_STREAM_CAPTURE, 0);
            if (rc >= 0)
            {
                if (defctlcard == card && defpcmcard == card && defpcmdev == device)
                    ALSA_AddCaptureDevice(ctl, pcm, TRUE);
                else
                    ALSA_AddCaptureDevice(ctl, pcm, FALSE);

                snd_pcm_close(pcm);
            }
            else
            {
                TRACE("Device [%s] not suitable for capture: %s\n",
                        pcmname, snd_strerror(rc));
            }

            /*----------------------------------------------------------------
            ** If the user has set environment variables such that
            **  we're pegged to a specific device (or if we've got no
            **  ctl device), then break out of the device scan loop
            **--------------------------------------------------------------*/
            if (fixedpcmdev != -1)
                break;
        }

        if (ctl)
            snd_ctl_close(ctl);

        /*--------------------------------------------------------------------
        ** If the user has set env variables such that we're pegged to
        **  a specific card, then break after we've examined it
        **------------------------------------------------------------------*/
        if (fixedpcmcard != -1)
            break;
    }

    return 0;

}

/*----------------------------------------------------------------------------
** ALSA_PerformDefaultScan
**  Perform the basic default scanning for devices within ALSA.
**  The hope is that this routine implements a 'correct' 
**  scanning algorithm from the Alsalib point of view.
**
**      Note that Wine, overall, has other mechanisms to
**  override and specify exact CTL and PCM device names,
**  but this routine is imagined as the default that
**  99% of users will use.
**
**      The basic algorithm is simple:
**  Use snd_card_next to iterate cards; within cards, use
**  snd_ctl_pcm_next_device to iterate through devices.
**
**      We add a little complexity by taking into consideration
**  environment variables such as ALSA_CARD (et all), and by
**  detecting when a given device matches the default specified
**  by Alsa.
**
**  Parameters:
**      plugflag        If !0, indicates we should use the plug:hw
**                      PCM interface, rather than the hw interface.
**                      The plug:hw interface performs automatic
**                      rate conversion and a bunch of other magic
**                      things that can be quite handy.
**
**  Returns:
**      0   on succes
**
**  Side Effects:
**      Invokes the ALSA_AddXXXDevice functions on valid
**  looking devices
**--------------------------------------------------------------------------*/
static int ALSA_PerformDefaultScan(int plugflag)
{
    long defctlcard = -1, defpcmcard = -1, defpcmdev = -1;
    int fixedctlcard = -1, fixedpcmcard = -1, fixedpcmdev = -1;
    int rc;
   
    rc = ALSA_DefaultDevices(plugflag, &defctlcard, &defpcmcard, &defpcmdev, 
            &fixedctlcard, &fixedpcmcard, &fixedpcmdev);
    if (rc)
        return(rc);

    return(ALSA_ScanDevices(plugflag, defctlcard, defpcmcard, defpcmdev, fixedctlcard, fixedpcmcard, fixedpcmdev));
}

int main(void)
{
    ALSA_PerformDefaultScan(0);
    ALSA_PerformDefaultScan(1);
    ALSA_RETURN_ONFAIL(snd_config_update_free_global());
    return 0;
}


--------------040809070409080903030403--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
