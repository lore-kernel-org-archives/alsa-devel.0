From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to set a new name on rawmidi?
Date: Sun, 3 Jan 2016 22:47:40 +0100
Message-ID: <568996FC.4070808@ladisch.de>
References: <CAL_NL1CKcX_d37SbopHH-bKUkfyXKvZxemVf58dH8ojcKwFQ=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id D52B32604DD
 for <alsa-devel@alsa-project.org>; Sun,  3 Jan 2016 22:48:26 +0100 (CET)
In-Reply-To: <CAL_NL1CKcX_d37SbopHH-bKUkfyXKvZxemVf58dH8ojcKwFQ=w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Viksporre <daniel.viksporre@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Viksporre wrote:
> I opened a MIDI connection with...
>
> snd_rawmidi_open(&read_handle, &write_handle, "virtual", 0);
>
> But how do i set a useful name on it, that can be seen in other programs?

You don't.

The RawMIDI API was designed for 'real' hardware devices, which already
have a name.

To create a virtual MIDI port, you should use the sequencer API.


Regards,
Clemens
