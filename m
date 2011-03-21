From: Daniel Mack <zonque@gmail.com>
Subject: Re: USB Quirks for Boss JS-8
Date: Mon, 21 Mar 2011 08:54:13 +0100
Message-ID: <AANLkTikU+shHE6Z4cz0Gecy9VO6bg=Cxvpjywrfxfck5@mail.gmail.com>
References: <201103181756.53155.maillist@superlative.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 70411103894
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 08:54:14 +0100 (CET)
Received: by ywg4 with SMTP id 4so2494143ywg.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 00:54:13 -0700 (PDT)
In-Reply-To: <201103181756.53155.maillist@superlative.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Keith A. Milner" <maillist@superlative.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 18, 2011 at 6:56 PM, Keith A. Milner
<maillist@superlative.org> wrote:
> Hi,
> I'm looking at developing a quirk for the Boss JS-8. The lsusb is as foll=
ows:
>

[...]

>
> I wasn't entirely sure about the quirk syntax as the two interfaces are a=
t EP
> 4 and EP5. Does this mean I need to ignore the (non-existant) lower
> interfaces? Here's what I came up with:
>
> {
> =A0 =A0 =A0 =A0/* Boss JS-8 Jam Station =A0*/
> =A0 =A0 =A0 =A0USB_DEVICE(0x0582, 0x0109),

Does this quirk help anything? I'm just asking because looking at the
descriptors,it's not clear whether this device does comply to any
standard interfaces at all. Could be the vendor just hides the
compliancy, but they might have implemented a proprietary protocol as
well.

Daniel
