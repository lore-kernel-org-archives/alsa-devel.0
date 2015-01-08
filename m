From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: AES/SPDIF channel status bits in ALSA
Date: Thu, 08 Jan 2015 14:27:10 +0100
Message-ID: <54AE85AE.2030206@perex.cz>
References: <54AE82A2.7070100@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id AE9EA260410
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 14:27:11 +0100 (CET)
In-Reply-To: <54AE82A2.7070100@barix.com>
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
Cc: Petr Kulhavy <petr@barix.com>
List-Id: alsa-devel@alsa-project.org

Dne 8.1.2015 v 14:14 Petr Kulhavy napsal(a):
> Hi,
> 
> is there a way to get the channel status bits information from an AES or 
> SPDIF input interface through ALSA and read it in userspace?
> I'm trying to solve some issues with the channel status bits sent from a 
> custom hardware and finding a way to analyse the channel status info.

Look for the IEC958 controls (amixer -c <cardnumber> contents), but most
hardware / drivers do not pass this information.

Some hardware is also able to receive the whole spdif frames - look for
drivers with SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_* types (like cmipci).

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
