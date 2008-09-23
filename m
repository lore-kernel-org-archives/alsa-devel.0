From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: Some idea about usb audio gadget driver.
Date: Tue, 23 Sep 2008 14:08:05 +0200
Message-ID: <48D8DC25.2060405@parrot.com>
References: <386072610809230250w2e43c20ei89076a8db62c5044@mail.gmail.com>
	<20080923104542.GB24627@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from toronto.xi-lite.net (co203.xi-lite.net [149.6.83.203])
	by alsa0.perex.cz (Postfix) with ESMTP id C9778244DA
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Sep 2008 14:08:09 +0200 (CEST)
In-Reply-To: <20080923104542.GB24627@gandalf.research.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: felipe.balbi@nokia.com
Cc: ext Bryan Wu <cooloney@kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Felipe Balbi a =E9crit :
> On Tue, Sep 23, 2008 at 05:50:33PM +0800, ext Bryan Wu wrote:
>> Hi ALSA and USB folks,
>>
>>
>>  - Is there any similar things on this planet?
>>  - How about gmidi usb midi gadget driver?
>>  - How can I open/playback/record/close a ALSA sound card in kernel
>> space not using alsalib in user space?
> =

> Start by converting gmidi to composite framework. Separate the alsa
> generic code from usb generic code and the function driver (in that case
> MIDI). Then, all you have to do is add a new function driver with proper
> audio streaming.
I am not sure there is lot's of common alsa code. IIRC Midi and Pcm API
are different in alsa.

But I think we shouldn't try to drive a sound card from kernel, we
should create an alsa sound card like gmidi, and let's userspace do what
it wants (redirect from/to another sound card, stream files, ...).


Mattieu
