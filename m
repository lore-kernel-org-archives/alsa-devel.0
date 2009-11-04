From: John Murphy <mr.proxxxy@gmail.com>
Subject: question re: creating a dummy midi device to be
	readable/writable by alsa/jack
Date: Tue, 3 Nov 2009 21:58:56 -0500
Message-ID: <9d5dae960911031858i83c4aeen742092127ee9b731@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FC2B2442A
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2009 03:58:58 +0100 (CET)
Received: by ewy21 with SMTP id 21so10702558ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 03 Nov 2009 18:58:57 -0800 (PST)
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

hi!
I'm currently working on a project to develop a driver for a midi controller
that is currently unsupported by Linux.
As this is going to be my first project with alsa/midi, I am trying to start
by creating a dummy midi device that can be loaded (where? kernel?
userspace?), be seen by jack as if it was a normal midi device and then work
on my reverse-engineering, debugging, etc. from there.
However, looking through the documentation, I'm not exactly sure on how to
start building this dummy device.
Can anyone help point me in the right direction?
Thanks, and sorry for the newbie question!
-- 
john
http://ghfdrvtsyup.net/proxxxy
