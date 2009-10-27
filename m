From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: What can change after suspend ?
Date: Tue, 27 Oct 2009 17:41:27 -0600
Message-ID: <51f3faa70910271641t7676a1b7n2ac63a9c450d962f@mail.gmail.com>
References: <20091028001750.62f12ef1@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f198.google.com (mail-iw0-f198.google.com
	[209.85.223.198])
	by alsa0.perex.cz (Postfix) with ESMTP id 324DB24484
	for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2009 00:41:28 +0100 (CET)
Received: by iwn36 with SMTP id 36so200439iwn.24
	for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2009 16:41:27 -0700 (PDT)
In-Reply-To: <20091028001750.62f12ef1@Jay>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Giuliano Pochini <pochini@shiny.it>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 27, 2009 at 5:17 PM, Giuliano Pochini <pochini@shiny.it> wrote:
> I'm adding suspend/resume support to echoaudio drivers. I was
> reading /Documentation/power/pci.txt:
>
> "
> =A0 =A0 =A0 =A0pci_set_power_state(PCI_D0);
> =A0 =A0 =A0 =A0pci_restore_state();
> =A0 =A0 =A0 =A0/* device's irq possibly is changed, driver should take ca=
re */
> "
>
> The card does not support D[0-3] states. The driver suspends the card by
> turning the DSP off, without changing the PCI state. Can IRQ, memory mapp=
ed
> regions, whatever, change on resume ?
> Are pci_save_state() and pci_enable_wake() useful/required in this case ?

I don't think an audio card would have need for pci_enable_wake, but
pci_save_state and pci_restore_state are mandatory, otherwise PCI
configuration space won't get restored after resume.
