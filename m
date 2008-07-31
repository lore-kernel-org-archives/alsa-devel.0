From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Proper way to set SCMS copy prohibited bits on
 IEC958 S/PDIF
Date: Thu, 31 Jul 2008 02:09:46 +0200
Message-ID: <489102CA.4010809@keyaccess.nl>
References: <76366b180807301337k3776e656p3b5edc6c0d2f56a5@mail.gmail.com>	
	<489100E4.70702@keyaccess.nl>
	<76366b180807301703n2dd1346dsa708ab60a7cc929f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 29A4F244AA
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Jul 2008 02:07:12 +0200 (CEST)
In-Reply-To: <76366b180807301703n2dd1346dsa708ab60a7cc929f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 31-07-08 02:03, Andrew Paprocki wrote:

> On Wed, Jul 30, 2008 at 8:01 PM, Rene Herman <rene.herman@keyaccess.nl> wrote:
>> On 30-07-08 22:37, Andrew Paprocki wrote:
>>
>>> I briefly checked the code for the Delta1010 (ice1712) to see if there
>>> was a way from user space to force the SCMS copy prohibited bits on in
>>> the S/PDIF stream. I see the driver initializes the bits to 0. Is
>>> there already a way to do this from user space, or would I have to
>>> modify the driver to force them on (or use a module parameter)?
>> I can't try this myself right now, but try "man iecset".
> 
> I actually found this code as well: http://www.cs.tut.fi/~ik/mpegspdif/output.c
> 
> It appears you can set the bits when opening the card by using a
> device string like this:
> 
> sprintf(devstr, "iec958:AES0=0x%x,AES1=0x%x,AES2=0x%x,AES3=0x%x",
> s[0], s[1], s[2], s[3]);
> 
> I'll look into both methods.

Yes, noticed that to (in /usr/share/alsa/pcm/iec958.conf) but couldn't 
tell you what the %x were, so "iecset" seemed like better advice...

Rene.
