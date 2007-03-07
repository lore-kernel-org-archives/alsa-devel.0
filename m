From: "Allyn, Mark A" <mark.a.allyn@intel.com>
Subject: Question on hda mixer structures
Date: Wed, 7 Mar 2007 08:34:48 -0800
Message-ID: <5FD5754DDBA0B1499B5A0B4BB5419485B0CC81@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
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

Folks:
 
I am trying to figure out how the mixer control structurs are done for
each of the
codecs in the patch_sigmatel file for the Sigmatel codecs.

A sample of one is as follows:

====================
static struct snd_kcontrol_new stac925x_mixer[] = {
        HDA_CODEC_VOLUME("Master Playback Volume", 0xe, 0, HDA_OUTPUT),
        HDA_CODEC_MUTE("Master Playback Switch", 0xe, 0, HDA_OUTPUT),
        {
                .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
                .name = "Input Source",
                .count = 1,
                .info = stac92xx_mux_enum_info,
                .get = stac92xx_mux_enum_get,
                .put = stac92xx_mux_enum_put,
        },
        HDA_CODEC_VOLUME("Capture Volume", 0x09, 0, HDA_OUTPUT),
        HDA_CODEC_MUTE("Capture Switch", 0x09, 0, HDA_OUTPUT),
        HDA_CODEC_VOLUME("Capture Mux Volume", 0x0f, 0, HDA_OUTPUT),
        { } /* end */
};
====================

I am having a hard time seeing the connection between the widgets that
have a volume
control and the entries in the stac mixer structure above. Where are the
NID's for each
entry of this structure? 

Also, the value HAD_OUTPUT is used apparently for both a capture node as
well as an
output node. Where would HDA_INPUT be used?

Is there any documentation on just how this structure is composed for a
new device?

Thanks for your help.

Mark

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
