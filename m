From: Klaus Schulz <kls.schlz@googlemail.com>
Subject: M-Audio Transit: Running asynchronous USB?
Date: Fri, 5 Jun 2009 11:47:35 +0200
Message-ID: <d9690f190906050247s1e40b6fflcf202eb268ac9bd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f217.google.com (mail-gx0-f217.google.com
	[209.85.217.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A4B024640
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Jun 2009 11:47:36 +0200 (CEST)
Received: by gxk17 with SMTP id 17so409407gxk.8
	for <alsa-devel@alsa-project.org>; Fri, 05 Jun 2009 02:47:35 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi there.

I would like to get a confirmation on below.

One of my USB soundcards is a M-Audio Transit.

cat /proc/asound/card0/stream0

lists below:

M-Audio Transit USB at usb-0000:00:1d.2-1.3, full speed : USB Audio

Playback:
  Status: Running
    Interface = 1
    Altset = 3
    URBs = 2 [ 1 1 ]
    Packet Size = 196
    Momentary freq = 44100 Hz (0x2c.199a)
  Interface 1
    Altset 1
    Format: 0x20 (24 bits)
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 48001 - 96000 (continuous)
  Interface 1
    Altset 2
    Format: 0x20 (24 bits)
    Channels: 2
    Endpoint: 3 OUT (NONE)
    Rates: 8000 - 48000 (continuous)
  Interface 1
    Altset 3
    Format: 0x2 (16 bits)
    Channels: 2
    Endpoint: 3 OUT (ASYNC)
    Rates: 8000 - 48000 (continuous)



Do I interprete it right that the Transit runs in asynchronous USB mode up
to 48khz and 16bit?
Does above also mean that <48/24 is not supported?


THX
Klaus
