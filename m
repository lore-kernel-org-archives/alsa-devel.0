From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - delay resume haswell hdmi
 codec in system resume
Date: Tue, 26 Mar 2013 11:58:27 +0100
Message-ID: <51517F53.7070608@canonical.com>
References: <1364321572-2634-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 26C30264FF9
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 11:58:27 +0100 (CET)
In-Reply-To: <1364321572-2634-1-git-send-email-mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/26/2013 07:12 PM, mengdong.lin@intel.com wrote:
> From: Mengdong Lin <mengdong.lin@intel.com>
>
> In system resume, Haswell codec cannot be programmed to D0 before Gfx driver
> initializes the display pipeline and audio, which will trigger an unsol event
> on the pin with HDMI/DP cable connected. Otherwise, the connected pin will
> stay in D3 with right channel muted and thus no sound can be heard.

Thanks for this patch!

Just a question: Is there a difference between real system S3 here, and 
just the normal idle power down? I e, I'm a little unsure myself, but it 
seems like this 300 ms delay would trigger in both cases, causing an 
(unnecessary?) 300 ms delay every time the codec is idle and you want to 
start playback. Is this correct, or did I get something wrong?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
