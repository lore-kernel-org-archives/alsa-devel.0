From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001971]: Some elements incorrectly have
	capture flags
Date: Fri, 30 Jun 2006 18:20:40 +0200
Message-ID: <6a1a1319dd9cbe05a9d82653fb4e636d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4D716265
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jun 2006 18:20:40 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1971> 
======================================================================
Reported By:                pzad
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1971
Category:                   simple mixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-28-2006 12:16 CEST
Last Modified:              06-30-2006 18:20 CEST
======================================================================
Summary:                    Some elements incorrectly have capture flags
Description: 
Some elemnts have capture flags even they have nothing to do with capture.
This will duplicate control in alsamixer - view ALL.

On VIA8233A + ALC650:

Simple mixer control '3D Control - Center',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 1 [7%]
Simple mixer control '3D Control - Depth',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]

On Audigy 1:
Simple mixer control 'Bass',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 40
  Front Left: 23 [58%]
  Front Right: 23 [58%]
Simple mixer control 'Treble',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 40
  Front Left: 27 [68%]
  Front Right: 27 [68%]


======================================================================

----------------------------------------------------------------------
 Raymond - 04-14-06 09:55 
----------------------------------------------------------------------
In View All of alsamixer, 

10-bands EQ peaks "Playback" appear as 2 stereo sliders and 2 mono
sliders.
10-bands EQ peaks "Capture" appear as 1 stereo slider.

The alsamixer still allow to increase/decrese even the kcontrol has been
declared access is read only (SNDRV_CTL_ELEM_ACCESS_READ)

static struct snd_kcontrol_new vortex_levels_kcontrol __devinitdata = {
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "EQ Peaks",
	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
	.info = snd_vortex_peaks_info,
	.get = snd_vortex_peaks_get,
};

ice1712 also has similar kcontrol

static int snd_ice1712_pro_peak_info(struct snd_kcontrol *kcontrol,
				     struct snd_ctl_elem_info *uinfo)
{
	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
	uinfo->count = 22;
	uinfo->value.integer.min = 0;
	uinfo->value.integer.max = 255;
	return 0;
}

static struct snd_kcontrol_new snd_ice1712_mixer_pro_peak __devinitdata =
{
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "Multi Track Peak",
	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
	.info = snd_ice1712_pro_peak_info,
	.get = snd_ice1712_pro_peak_get
};



----------------------------------------------------------------------
 Raymond - 06-30-06 18:20 
----------------------------------------------------------------------
Are there any method to remove those "3D Control" from capture view of
alsamixer 1.0.12rc1 ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-28-06 12:16 pzad           New Issue                                    
03-30-06 11:01 Raymond        Note Added: 0009028                          
03-30-06 12:50 pzad           Note Added: 0009031                          
03-30-06 13:13 pzad           Note Added: 0009032                          
03-30-06 13:22 Raymond        Note Added: 0009033                          
03-30-06 13:29 Raymond        Note Edited: 0009033                         
03-30-06 13:41 Raymond        Note Edited: 0009033                         
03-31-06 04:36 Raymond        Note Added: 0009041                          
03-31-06 04:50 Raymond        Note Edited: 0009041                         
04-01-06 01:13 Raymond        Note Edited: 0009033                         
04-03-06 19:08 Raymond        Note Added: 0009103                          
04-05-06 18:42 Raymond        Note Added: 0009121                          
04-05-06 18:46 Raymond        Note Edited: 0009121                         
04-05-06 18:50 Raymond        Note Edited: 0009121                         
04-06-06 09:11 Raymond        Note Deleted: 0009103                        
04-06-06 09:44 Raymond        Note Added: 0009124                          
04-06-06 09:45 Raymond        Note Edited: 0009124                         
04-07-06 12:05 Raymond        Note Added: 0009136                          
04-13-06 11:32 Raymond        Note Added: 0009256                          
04-13-06 20:26 pzad           Note Added: 0009268                          
04-14-06 06:21 Raymond        Note Added: 0009282                          
04-14-06 09:55 Raymond        Note Edited: 0009282                         
06-30-06 18:20 Raymond        Note Added: 0010749                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
