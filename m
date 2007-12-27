From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: intel-hd on an intel G33 motherboard
Date: Wed, 26 Dec 2007 21:30:42 -0500
Message-ID: <75b66ecd0712261830m38f9d090n8d53e9bff193318a@mail.gmail.com>
References: <BAY109-W10EC413FC1F19625739A28A95B0@phx.gbl>
	<1198697428.3732.176.camel@razman.gruemaster.com>
	<BAY109-W373CBC57EE1663E94F98D8A9540@phx.gbl>
	<1198716447.3732.193.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 4944A243AB
	for <alsa-devel@alsa-project.org>; Thu, 27 Dec 2007 03:30:44 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so1700062rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 26 Dec 2007 18:30:42 -0800 (PST)
In-Reply-To: <1198716447.3732.193.camel@razman.gruemaster.com>
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
To: Tobin Davis <tdavis@dsl-only.net>
Cc: ALSA Developers <alsa-devel@alsa-project.org>, De Fuuss <fuuss@hotmail.com>
List-Id: alsa-devel@alsa-project.org

On Dec 26, 2007 7:47 PM, Tobin Davis <tdavis@dsl-only.net> wrote:
> Ok, the second codec is the HDMI port.  For some reason, it is getting
> assigned to be primary sound device.  Try "alsamixer -D hw:1.0" to see
> if it can control the realtek device.
>
> Oddly enough, I used to work at Intel as a contractor, developing audio
> drivers for their boards.  They stopped supporting Linux when my
> contract ended.

Just curious - is there really anything Intel could do at this point
to improve the snd-hda-intel situation?  My impression is that their
decision to architect the thing such that every vendor can wire things
up their own way (or "add value" in marketing speak) is the root of
the support nightmare that these devices are.

It seems that the only way to improve things would be to either get
every single PC vendor to help, or make the pin configs settable from
userspace and develop a tool to translate from the vendor provided
Windows .inf files.

Do I grok the situation correctly?

;-)

Lee
