From: Petr Kulhavy <petr@barix.com>
Subject: DT soundcard driver with special clock routing
Date: Thu, 10 Dec 2015 17:31:26 +0100
Message-ID: <5669A8DE.7060702@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D8A22654AD
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 17:31:29 +0100 (CET)
Received: by mail-wm0-f44.google.com with SMTP id c201so41543864wme.0
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 08:31:29 -0800 (PST)
Received: from [192.168.11.22] (80-218-157-3.dclient.hispeed.ch.
 [80.218.157.3])
 by smtp.gmail.com with ESMTPSA id 198sm13675265wmr.18.2015.12.10.08.31.26
 for <alsa-devel@alsa-project.org> (version=TLSv1/SSLv3 cipher=OTHER);
 Thu, 10 Dec 2015 08:31:26 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm developing a DT-based driver for an ARM SoC device with the =

following special clock routing:

- WM8758 codec attached to the CPU DAI via I2S
- the codec is I2S clock master
- the CPU feeds the codec with 12MHz clock (outside of the I2S)
- the codec converts the 12MHz  internally to 48kHz*256 or 44.1kHz *256 =

clock and provides it to I2S as MCLK

So the special set-up needed here is that the codec needs to be =

configured to:
a) generate the proper MCLK
b) enable the respective GPIO pin as clock output

What is the best way of representing this set-up using device tree?
I'm wondering if this can be done by adding a specific option in the =

codec DT binding for enabling the clock output and then use the simple =

audio card.
Or do I need to write a specific soundcard driver that sets up the codec =

registers? I would like to avoid that if possible and use existing code...

What would you recommend?

Thanks

-- =

Petr Kulhavy, MSc
System Architect

*BARIX*

petr@barix.com <mailto:petr@barix.com> | Skype: brain.barix

Barix AG, Seefeldstrasse 303 | 8008 Zurich, Switzerland
T +41 43 43322 11 | www.barix.com <http://www.barix.com>

You have received this email because of your relationship Barix AG and =

its affiliated companies. Barix AG and its affiliated companies do not =

sell or exchange email addresses, or any other personal contact =

information provided by you with any third parties. All email =

distributions are managed and controlled by Barix AG and its affiliated =

companies.
Barix AG, Seefeldstr. 303, 8008 Z=FCrich, Switzerland. Company Reg. No: =

CH-020.3.023.869-8, VAT Reg. No: CHE-105.687.663.
