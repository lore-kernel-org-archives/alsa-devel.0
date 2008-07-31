From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: Proper way to set SCMS copy prohibited bits on
	IEC958 S/PDIF
Date: Wed, 30 Jul 2008 20:03:40 -0400
Message-ID: <76366b180807301703n2dd1346dsa708ab60a7cc929f@mail.gmail.com>
References: <76366b180807301337k3776e656p3b5edc6c0d2f56a5@mail.gmail.com>
	<489100E4.70702@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 28266244A8
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Jul 2008 02:03:41 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so229731rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2008 17:03:40 -0700 (PDT)
In-Reply-To: <489100E4.70702@keyaccess.nl>
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
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 30, 2008 at 8:01 PM, Rene Herman <rene.herman@keyaccess.nl> wrote:
> On 30-07-08 22:37, Andrew Paprocki wrote:
>
>> I briefly checked the code for the Delta1010 (ice1712) to see if there
>> was a way from user space to force the SCMS copy prohibited bits on in
>> the S/PDIF stream. I see the driver initializes the bits to 0. Is
>> there already a way to do this from user space, or would I have to
>> modify the driver to force them on (or use a module parameter)?
>
> I can't try this myself right now, but try "man iecset".

I actually found this code as well: http://www.cs.tut.fi/~ik/mpegspdif/output.c

It appears you can set the bits when opening the card by using a
device string like this:

sprintf(devstr, "iec958:AES0=0x%x,AES1=0x%x,AES2=0x%x,AES3=0x%x",
s[0], s[1], s[2], s[3]);

I'll look into both methods.

Thanks, -Andrew
