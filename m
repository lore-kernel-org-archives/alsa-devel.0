From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: hda-intel codec realtec ALC883
Date: Tue, 20 Nov 2007 13:12:49 -0500
Message-ID: <75b66ecd0711201012v472ba792j975e7c7e32ed6856@mail.gmail.com>
References: <47430DA7.8090504@sejo.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by alsa0.perex.cz (Postfix) with ESMTP id EB756246BD
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 19:12:50 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so1490958rvb
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 10:12:49 -0800 (PST)
In-Reply-To: <47430DA7.8090504@sejo.be>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jochen Maes <jochen.maes@sejo.be>
Cc: alsa-devel@alsa-project.org, alsa-bugs@gentoo.org
List-Id: alsa-devel@alsa-project.org

On Nov 20, 2007 11:39 AM, Jochen Maes <jochen.maes@sejo.be> wrote:
> 2) launch alsamixer, go to the capture screen, select the "capture" and
> press spacebar + set to 75, d the same for "capture 1"

That's exactly the expected behavior.  You need to unmute the capture
channels and set levels to capture anything.

Lee
