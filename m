From: Borg Onion <borg.onion@gmail.com>
Subject: What's the deal with elements?
Date: Tue, 22 Nov 2011 20:44:03 -0800
Message-ID: <CAAs5ODuE2MPa9WULW-rWSwcBxdPTJk35fUqPYsvMBzCv=QjK-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 44F16103A50
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 05:44:05 +0100 (CET)
Received: by ywp27 with SMTP id 27so1019990ywp.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 20:44:04 -0800 (PST)
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

Hi,

Still writing some basic ALSA software, trying to get to know the API.  I
wrote some software to list cards and their properties, with output like
this:

$ ./list
Card #0: id=ICH6, driver=ICH4, name=Intel ICH6, longname=Intel ICH6 with
AD1981B at irq 17, mixername=Analog Devices AD1981B,
components=AC97a:41445374
Element used = 0, count = 28
Power state = D0
CTL type = Kernel level CTL
Card #1: id=Device, driver=USB-Audio, name=C-Media USB Audio Device,
longname=C-Media USB Audio Device at usb-0000:00:1d.0-1, full speed,
mixername=USB Mixer, components=USB0d8c:0008
Element used = 0, count = 7
Power state = D0
CTL type = Kernel level CTL
No more cards!

Whenever I try to access the elements by their index though, I get errors.
 What's the meaning of "used" vs. "count"?  What are these elements used
for?  I would assume to discover what devices are on a card, but I could be
wrong.  How does one do device discovery?

Thanks,

--BO
