From: Steve Strobel <steve.strobel@link-comm.com>
Subject: Driver for daisy-chained AD1938 audio codecs?
Date: Tue, 11 Oct 2011 12:23:40 -0600
Message-ID: <CAGrmWbwWCBWjTA4OHN=Up7tbOg0HbdbikT3XcXQ9LpnoFmhHrw@mail.gmail.com>
Reply-To: steve.strobel@link-comm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 339AE103917
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Oct 2011 20:24:03 +0200 (CEST)
Received: by ywn1 with SMTP id 1so7950689ywn.38
	for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2011 11:24:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am considering a Blackfin DSP hardware design which would need eight
channels of audio input/output. I haven't been able to find a single
audio codec with more than six input channels, so I am looking at
daisy-chaining AD1938 codecs as described on page 19 of its datasheet
[1].

In the past I worked on a prototype that used two AD1938 chips on
separate SPORT interfaces. It worked, but having to deal with two ALSA
sound devices made the software relatively complicated (error
recovery, synchronization, etc). It would be nice if all of the
channels appeared as a single ALSA device.  I believe that
daisy-chained AD1938 chips would work that way, but I haven't found an
ALSA driver for that configuration.

Does such a driver already exist?  Any suggestions for making one?
Thanks for any input.

Steve

[1] - http://www.analog.com/static/imported-files/data_sheets/AD1938.pdf


--
Steve Strobel
Link Communications, Inc.
1035 Cerise Rd
Billings, MT 59101-7378
(406) 245-5002 ext 102
(406) 245-4889 (fax)
WWW: http://www.link-comm.com
MailTo:steve.strobel@link-comm.com
