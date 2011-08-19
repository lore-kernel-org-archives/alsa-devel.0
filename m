From: Ulo Mets <umets@osa.pri.ee>
Subject: Re: Conexant 5051 lenovo-x200 fixes
Date: Fri, 19 Aug 2011 03:00:58 +0300
Message-ID: <4E4DA7BA.5020704@osa.pri.ee>
References: <4E4C60AD.2090806@osa.pri.ee> <s5hzkj7t4ju.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from polaris.osa.pri.ee (polaris.osa.pri.ee [194.204.58.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 66CF42439F
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 02:01:36 +0200 (CEST)
In-Reply-To: <s5hzkj7t4ju.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/18/2011 01:08 PM, Takashi Iwai wrote:
> At Thu, 18 Aug 2011 03:45:33 +0300,
> Ulo Mets wrote:
>> Hi,
>> I am not a kernel developer, but occasionally dig into it if something gets in my way.
>> On Lenovo X200 Tablet none of the mixers showed Mic Boost adjustments, but HDA-Analyzer found them
>> and adjusted properly. So I inserted the corresponding controls, and it worked.
>> Then, during testing I found that the labels of External and Docking Mic are swapped,
>> so I exchanged these too. Since I could not test it on other hardware, I put it all on lenovo-x200 branch.
>> The patch applies to 3.1-rc2, I hope it is sufficiently recent.
>> The Mic Switches don't have any effect on my unit (X200T without modem)
> Could you try model=auto instead of patching?
> The recent auto-parser should work better.
Model=auto seems to give a very generic configuration, which indeed does 
include working
Mic boost for Internal Mic. (Ext?) Mic Boost and gain are also present, 
but jack sensing does not work,
so these cannot be tested.
Also, the Dock Microphone is not detected, so I would conclude that for 
X200T "auto" does not work.

It would be surprising if Auto was better than dedicated model. (X200 
and X200T accept
same part numbers for audio card).
The kernel version that I used for this latest testing is 3.0-ARCH

It would be nice to get the mute switches to work as well.
