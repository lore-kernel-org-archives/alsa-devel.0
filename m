From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC 0/4] ALSA controls management using
 index/device/sub-devices fields
Date: Sat, 12 Nov 2016 22:17:21 +0900
Message-ID: <dccae745-113d-7baa-47d4-aed0784260bf@sakamocchi.jp>
References: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
 <c28a3623-3cf1-5fc1-1ba8-e6785fb967ca@sakamocchi.jp>
 <cb9cf7f0-ae86-307b-c4d6-b4d3120d4e88@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id CA11B266218
 for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2016 14:17:28 +0100 (CET)
In-Reply-To: <cb9cf7f0-ae86-307b-c4d6-b4d3120d4e88@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Nov 9 2016 23:38, Arnaud Pouliquen wrote:
> Other solution: use control "prefix"? not possible as control has a
> pre-defined name.

I note that we can give unique names to control element set for IEC 
60958. According to this document, Between "IEC958" and the rest, we can 
put arbitrary string.
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/Documentation/sound/designs/control-names.rst

For your information.


Takashi Sakamoto
