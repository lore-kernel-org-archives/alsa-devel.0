From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 00/10] Add proper resume support to
	USB-audio quirks
Date: Thu, 20 Nov 2014 18:33:25 +0100
Message-ID: <1416504815-28685-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DF2426061E
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 18:33:47 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E3F17AD7F
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 17:33:46 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

here is a patch series to add proper resume support to USB-audio quirks.
So far, the control elements created directly by quirk functions aren't
resumed restore_mixer_value().  This patch series try to address it.

 [PATCH RFC 01/10] ALSA: usb-audio: Refactor ignore_ctl_error checks
 [PATCH RFC 02/10] ALSA: usb-audio: Allow quirks to handle own resume
 [PATCH RFC 03/10] ALSA: usb-audio: Add audigy2nx resume support
 [PATCH RFC 04/10] ALSA: usb-audio: Add Emu0204 channel switch resume
 [PATCH RFC 05/10] ALSA: usb-audio: Add Xonar U1 resume support
 [PATCH RFC 06/10] ALSA: usb-audio: Add Digidesign Mbox 1 resume
 [PATCH RFC 07/10] ALSA: usb-audio: Add resume support for Native
 [PATCH RFC 08/10] ALSA: usb-audio: Add resume support for FTU
 [PATCH RFC 09/10] ALSA: usb-audio: Add resume support for MicroII
 [PATCH RFC 10/10] ALSA: usb-audio: Add resume support for Scarlett

I have only compile-tested this, so far.  It'd be appreciated if anyone
with such devices can test with real devices.


thanks,

Takashi
