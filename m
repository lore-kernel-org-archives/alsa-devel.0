From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: Playback and capture synchronization
Date: Thu, 10 Nov 2011 11:36:58 +1300
Message-ID: <4EBB008A.7070500@audioscience.com>
References: <4EB9E331.8070401@codeaurora.org> <4EBA6A22.6090308@ladisch.de>
	<4EBAC88D.1040508@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gwa4.webcontrolcenter.com (gwa4.webcontrolcenter.com
	[63.134.207.18]) by alsa0.perex.cz (Postfix) with ESMTP id AE43124381
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 23:37:52 +0100 (CET)
In-Reply-To: <4EBAC88D.1040508@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 10/11/11 07:38, Patrick Lai wrote:
> It's Qualcomm hardware. As far as I know, HW has this synchronization 
> support but I would have to build driver to make use of this functionality

To see examples of drivers that support HW linking, search for
snd_pcm_group_for_each_entry

-- 
Eliot Blennerhassett
AudioScience Inc.
