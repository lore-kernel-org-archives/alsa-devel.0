From: Bin Gao <bin.gao@intel.com>
Subject: There is no sound from speaker on Toshiba NB200
Date: Wed, 18 Nov 2009 10:55:24 +0800
Message-ID: <1258512924.1970.100.camel@DG965>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D7F710385F
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 03:53:47 +0100 (CET)
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

[re-send because the previous one is not plain text format)

The quirk "SND_PCI_QUIRK(0x1179, 0xff6e, "Toshiba NB200",
ALC663_ASUS_MODE4)" works on Toshiba NB200
but for playback, I only get sound from HP and never from SPK.
As observed by hda-verb, the HP pipeline is DAC (nid 0x03) --> Mux (nid
0x0D) --> pin HP-OUT (nid 0x21)
and it works fine.
I noted that unsol event(HP plugged and unplugged) can be detected by
the codec ALC272.
According to the ALC272 datasheet, the SPK pin seems either 0x14 or
0x15, but there was still no sound from
SPK even I manually set up the pipeline(DAC 0x03 --> Mux 0x0D --> pin
0x14 or 0x15) by hda-verb.

For ALC663_ASUS_MODE4, dacs are defined as
static hda_nid_t alc662_dac_nids[4] = {
        /* front, rear, clfe, rear_surr */
        0x02, 0x03, 0x04
};
and hp_nid is defined as 0x03.
So as I understand, one HDA stream(from HDA controller) is copied to
both DAC 0x02 and 0x03.
Then I manually set up another pipeline (DAC 0x02 --> Mux 0x0C --> pin
0x14 or 0x15) , still no sound.
I checked the init verbs of ALC663_ASUS_MODE4 from patch_realteck.c and
didn't find any missing settings.

Any ideas?

Thanks,
Bin
