From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] Provide card number / PID via
	sequencer	client info
Date: Tue, 16 Feb 2016 09:59:37 +0100
Message-ID: <56C2E4F9.6030204@ladisch.de>
References: <1455370937-501-1-git-send-email-martin@mail.zuhause>
 <1455370937-501-3-git-send-email-martin@mail.zuhause>
 <s5htwlab70o.wl-tiwai@suse.de> <20160215183243.GA26482@mail.zuhause>
 <s5hziv194gz.wl-tiwai@suse.de> <20160215214454.GA11052@mail.zuhause>
 <s5hsi0t8uxq.wl-tiwai@suse.de> <20160216080334.GA15116@mail.zuhause>
 <s5hio1p82t6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 637E5260686
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 09:59:40 +0100 (CET)
In-Reply-To: <s5hio1p82t6.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Martin Koegler <martin.koegler@chello.at>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Martin Koegler wrote:
>> On Mon, Feb 15, 2016 at 11:34:09PM +0100, Takashi Iwai wrote:
>>>> On Mon, Feb 15, 2016 at 08:08:12PM +0100, Takashi Iwai wrote:
>>>>> Well, the question is whether only card number is enough.  What if
>>>>> cards provide multiple rawmidi devices?
>>>>
>>>> Aren't they currently ports?
>>>> seq_midi.c creates just one sequencer device per card number.
>>>
>>> Look at cards with synth support, e.g. emu10k1 or OPL3/OPL4.

Or snd-virmidi.

>> Should I export the client_index parameter of snd_seq_create_kernel_client too?
>
> Well, I'd rather ask what are the requirements -- in wide ranges.

The original requirement was just the ability to get the card name.

> As you already noticed, multiple rawmidi devices and rawmidi
> subdevices are mapped into a single client with various ports.

Actually, multiple devices get multiple clients.

> And, as mentioned, some cards provide indeed multiple clients.  How do
> you identify which client is for what?  So far, it's identified only
> from the name string and the type bits of each port.  Isn't it enough?
> If not, what have to be provided?

This patch is about the card.  If we really need a method to identify
the device, we can still add it later -- this patch does not obstruct
such an extension.


Regards,
Clemens
