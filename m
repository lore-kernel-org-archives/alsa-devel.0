From: "van der Linden" <ejvanderlinden@hetnet.nl>
Subject: LADSPA plugin in ALSA pcm-plugin layer
Date: Tue, 12 Feb 2008 18:00:39 +0100
Message-ID: <004a01c86d98$cb7e2e80$0202a8c0@uw4b58d8528225>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hpsmtp-eml14.kpnxchange.com (hpsmtp-eml14.KPNXCHANGE.COM
	[213.75.38.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EEE71037FD
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 18:00:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying to use a LADSPA plugin in the pcm-plugin layer of the ALSA userspace library.
However I get an error saying ALSA needs two control ports (input and output) while the plugin only has one input control port.

What could be the problem?

Thanks for your help

E-J


Below are all the details:

I'm running the software on a Blackfin DSP processor with uCLinux.
The plugin is obtained from LADSPA org.
The tools analyseplugin and applyplugin (as delivered within the LADSPA SDK) do work correctly.
I use the amp.so plugin.

The error:
----------------------------------------------------------------------
Use 'aplay' with LADSPA plugin : error because of missing output control
----------------------------------------------------------------------
root:~> aplay -D myladspa test.wav
Init AMP plugin
AMP ladspa descriptor, index = 0
AMP ladspa descriptor, index = 1
ALSA lib ../../../alsa-lib-1.0.12/src/pcm/pcm_ladspa.c:1361:(snd_pcm_ladspa_parse_ioconfig) error adding default controls
aplay: main:550: audio open error: Cannot allocate memory

The plugin info:
----------------------------------------------------------------------
AMP.SO plugin info
----------------------------------------------------------------------
root:~> analyseplugin amp.so
Init AMP plugin
AMP ladspa descriptor, index = 0

Plugin Name: "Mono Amplifier"
Plugin Label: "amp_mono"
Plugin Unique ID: 1048
Maker: "Richard Furse (LADSPA example plugins)"
Copyright: "None"
Must Run Real-Time: No
Has activate() Function: No
Has deactivate() Function: No
Has run_adding() Function: No
Environment: Normal or Hard Real-Time
Ports:  "Gain" input, control, 0 to ..., default 1, logarithmic    <== one input control port
        "Input" input, audio
        "Output" output, audio
AMP ladspa descriptor, index = 1

Plugin Name: "Stereo Amplifier"
Plugin Label: "amp_stereo"
Plugin Unique ID: 1049
Maker: "Richard Furse (LADSPA example plugins)"
Copyright: "None"
Must Run Real-Time: No
Has activate() Function: No
Has deactivate() Function: No
Has run_adding() Function: No
Environment: Normal or Hard Real-Time
Ports:  "Gain" input, control, 0 to ..., default 1, logarithmic        <== one input control port
        "Input (Left)" input, audio
        "Output (Left)" output, audio
        "Input (Right)" input, audio
        "Output (Right)" output, audio
AMP ladspa descriptor, index = 2

The config file:
----------------------------------------------------------------------
asound.conf
----------------------------------------------------------------------
pcm.myladspa{
 type ladspa
 slave {
  pcm default
 }

 path "/usr/lib/ladspa";
 plugins [
  {
   label "amp_stereo"
   filename "amp.so"
   policy "duplicate"
   output {
    controls[1]
   }
   input {
    controls[1]
   }
 }
 ]
}

ctl.myladspa{
 type hw
 card 0
}

ALSA always tries to open a input and output control port...
----------------------------------------------------------------------
pcm_ladspa.c  
----------------------------------------------------------------------
--- snd_pcm_ladspa_parse_ioconfig is always called, for input AND output control ---
in function snd_pcm_ladspa_add_plugin (line 1512):

 err = snd_pcm_ladspa_parse_ioconfig(lplug, &lplug->input, input);
 if (err < 0)
  return err;
 err = snd_pcm_ladspa_parse_ioconfig(lplug, &lplug->output, output);
 if (err < 0)
  return err;

I think here might be an error or is it agreed a plugin ALWAYS has two control ports...
----------------------------------------------------------------------
pcm_ladspa.c  
----------------------------------------------------------------------
--- if no output control found, calloc (0, sizeof...) results in -ENOMEM error ---

static int snd_pcm_ladspa_add_default_controls(snd_pcm_ladspa_plugin_t *lplug,
            snd_pcm_ladspa_plugin_io_t *io) 
{
 unsigned int count = 0;
 LADSPA_Data *array;
 unsigned char *initialized;
 unsigned long idx;

 for (idx = 0; idx < lplug->desc->PortCount; idx++)
  if ((lplug->desc->PortDescriptors[idx] & (io->pdesc | LADSPA_PORT_CONTROL)) == (io->pdesc | LADSPA_PORT_CONTROL))
   count++;
 array = (LADSPA_Data *)calloc(count, sizeof(LADSPA_Data));
 if (!array)
  return -ENOMEM;
