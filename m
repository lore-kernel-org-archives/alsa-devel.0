From: Stephen Warren <swarren@nvidia.com>
Subject: HDMI audio: TV vs. codec supported sample rates
Date: Tue, 3 Aug 2010 09:04:40 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF02FD6DF319@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E63124503
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 18:04:16 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'alsa-devel' <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

A user has the following setup:

A GPU which supports audio-over-HDMI. The codec supports sample rates 32000 44100 48000 88200 96000 176400 192000 (from /proc/asound/card1/codec#1). However, the user's TV supports only sample rates 44100 48000 88200 (from /proc/asound/card1/eld*).

When the user plays sound with sample rate 22050, they hear nothing. Sound with sample rates supported by the TV works OK.

My question: Is the HDA codec driver supposed to dynamically adjust its list of supported sample rates based on the ELD content, or is the ALSA library somehow supposed to detect the subset of rates supported in HW and convert the sample rate in SW before sending the audio to the driver?

Thanks for any insight.

-- 
nvpublic
