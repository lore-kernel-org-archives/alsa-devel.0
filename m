From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Some idea about usb audio gadget driver.
Date: Tue, 23 Sep 2008 13:45:42 +0300
Message-ID: <20080923104542.GB24627@gandalf.research.nokia.com>
References: <386072610809230250w2e43c20ei89076a8db62c5044@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id EB4BE244A6
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Sep 2008 12:46:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <386072610809230250w2e43c20ei89076a8db62c5044@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Bryan Wu <cooloney@kernel.org>
Cc: ALSA devel <alsa-devel@alsa-project.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 23, 2008 at 05:50:33PM +0800, ext Bryan Wu wrote:
> Hi ALSA and USB folks,
> 
> I plan to develop a usb audio gadget driver on Blackfin platform (can
> be shared for other embedded system).
> 
>  - A new usb gadget driver which recognized by Linux/Windows PC as an
> USB audio card.
>  - There is an ALSA sound card on the same embedded device.
>  - The usb gadget driver receives audio data from host and send them
> to ALSA sound card to playback
>  - The usb gadget driver send the audio data recorded by ALSA sound
> card to host as recording.
>  - The usb gadget driver response to some audio card control command
> such as volume/mute control
> 
> Questions,
> 
>  - Is there any similar things on this planet?
>  - How about gmidi usb midi gadget driver?
>  - How can I open/playback/record/close a ALSA sound card in kernel
> space not using alsalib in user space?

Start by converting gmidi to composite framework. Separate the alsa
generic code from usb generic code and the function driver (in that case
MIDI). Then, all you have to do is add a new function driver with proper
audio streaming.

Later on someone might be interested in adding mic support ;-)

-- 
balbi
