From: "S. Aguinaga" <sa_jr@yahoo.com>
Subject: Echo Indigo card on Sabayon Gentoo
Date: Thu, 14 Jan 2010 12:13:55 -0800 (PST)
Message-ID: <898710.10745.qm@web65614.mail.ac4.yahoo.com>
Reply-To: "S. Aguinaga" <sa_jr@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n7b.bullet.mail.ac4.yahoo.com (n7b.bullet.mail.ac4.yahoo.com
	[76.13.13.77]) by alsa0.perex.cz (Postfix) with SMTP id 92A28103907
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 21:13:57 +0100 (CET)
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

Hello Fellows, 
Just downloaded the latest (released)  alsa-lib, alsa-driver, and alsa-utils, but my Indigo card does not work. It has been tested on the same system using the same drivers and on the same system using Fedora 10, that works fine.  

Do you know what I might have to do to get it working on Gentoo (sabayon)?

When I type the following, this is what I get:
~/Downloads/alsa-utils-1.0.22/alsactl $ ./alsactl  init 2
Unknown hardware: "Echo_Indigo IO" "" "" "0xecc0" "0x00a0"
Hardware is initialized using a guess method

Using aplay to list the device:
card 2: IO [Indigo IO], device 0: PCM [Indigo IO]
  Subdevices: 8/8
.... etc.

Using aplay to test the card here is the command:
aplay -D plughw:2,0  <wav file>

And this does not work, I have checked that things are ok with alsamixer, but still!

Any help will be appreciated or let me know if this is best addressed by submitting a bug.

// Salvador
