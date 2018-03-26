From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC,
 alsa-utils] RFC: alsamixer: Improve description of playback switches
Date: Mon, 26 Mar 2018 17:19:05 +0900
Message-ID: <0f684e10-d8b0-611b-50a3-b982658de0c3@sakamocchi.jp>
References: <20180326051144.16672-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 7436C266A73
 for <alsa-devel@alsa-project.org>; Mon, 26 Mar 2018 10:19:07 +0200 (CEST)
In-Reply-To: <20180326051144.16672-1-k.marinushkin@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kirill Marinushkin <k.marinushkin@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mar 26 2018 14:11, Kirill Marinushkin wrote:
> Currently, all playback switches are described as mute. It is shown as:
> 
> [OO] == sound is on (left and right channels)
> [MM] == sound is muted (left and right channels)
> 
> But cards can have different kinds of switch controls, not only mute. At
> least usb-audio provides boolean controls as playback switches for:
> 
> * clock source validity (read only switch)
> * processing features on/off (rw switch)
> * potentially other similar use-cases
> 
> It becames confusing, because it is shown as:
> 
> [OO] == clock source is valid
> [MM] == clock source is invalid
> 
> [OO] == processing feature is on
> [MM] == processing feature is off
> 
> And from the help, it is not clear how to toggle such switches.

Could you show such control elements to help reviewers? For example, 
output from 'amixer' might be enough.


Regards

Takashi Sakamoto
