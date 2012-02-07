From: Stephen Warren <swarren@nvidia.com>
Subject: Re: ALSA 1.0.25 broke AC3 passthrough?
Date: Mon, 06 Feb 2012 21:46:37 -0800
Message-ID: <4F30BABD.10504@nvidia.com>
References: <CANpj82+DPJGg1vUvm-otVEWEeXwK8zOy4ZAGjFH81oc5n51CTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 9430F24489
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 06:46:42 +0100 (CET)
In-Reply-To: <CANpj82+DPJGg1vUvm-otVEWEeXwK8zOy4ZAGjFH81oc5n51CTw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean-Yves Avenard <jyavenard@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 02/06/2012 04:38 AM, Jean-Yves Avenard wrote:
> Today, I installed 1.0.25 drivers and libraries...
> AC3 passthrough is completely broken.
> 
> My hardware: NVidia GT430, hdmi output
> Device used:
> hdmi:CARD=NVidia,DEV=0,AES0=6,AES1=0x82,AES2=0x00,AES3=0x01
> on Ubuntu 10.04 LTS (but using manually built alsa)

Are you able to regress this to a smaller window? I did do some rework a
while back on the HDA driver to support newer GeForce GPUs' audio HW
better, and this potentially had impact on bitstream pass-through,
although it seemed to work at the time. Commits were:

384a48d ALSA: hda: HDMI: Support codecs with fewer cvts than pins
2def817 ALSA: hda: hdmi_eld_update_pcm_info: update a stream in place
3aaf898 ALSA: hda: Separate generic and non-generic implementations
74b654c ALSA: hda: Virtualize SPDIF out controls
7c93597 ALSA: hda: Allow multple SPDIF controls per codec

-- 
nvpublic
