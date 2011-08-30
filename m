From: Daniel Mack <zonque@gmail.com>
Subject: Re: Status of Zoom R16
Date: Tue, 30 Aug 2011 09:21:39 +0200
Message-ID: <CACTFLAMUOjXYbjjZjjTs1bbmu=4Wr9XDeaim7s5Dvn=M1HJX7A@mail.gmail.com>
References: <CAPk1tZaonL+bkH2sO+iUmEbAwuOWwecB9V39tQNHvQ0PKc=a+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id D4CAD244F9
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 09:21:40 +0200 (CEST)
Received: by pzk1 with SMTP id 1so10437372pzk.2
	for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2011 00:21:39 -0700 (PDT)
In-Reply-To: <CAPk1tZaonL+bkH2sO+iUmEbAwuOWwecB9V39tQNHvQ0PKc=a+w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Evan Ta <evan.ta.88@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 30, 2011 at 9:04 AM, Evan Ta <evan.ta.88@gmail.com> wrote:
> Hi,
>
> as subj says: can you tell me how the Zoom R16 is doing? The hardware looks
> nice, but the latest info I can find is a seemingly unresolved failure to
> work with Alsa as of feb 2010.

Yes, it's currently unsupported. The device doesn't comply to the USB
audio spec, and nobody with such hardware has yet taken the time to
implement a driver.

You can try contact their support and ask whether they are willing to
release the protocol spec under a free licence, that could speed up
the process. Otherwise, someone will need to trace the communication
and reverse-engineer it.


Daniel
