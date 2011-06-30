From: David Henderson <dhenderson@digital-pipe.com>
Subject: Re: additional problem
Date: Thu, 30 Jun 2011 11:43:46 -0400
Message-ID: <4E0C99B2.3070103@digital-pipe.com>
References: <4E0B2F67.3070304@digital-pipe.com>
	<4E0C68ED.1070506@digital-pipe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7F1E824599
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jun 2011 17:45:40 +0200 (CEST)
Received: by ywm39 with SMTP id 39so1046600ywm.38
	for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2011 08:45:39 -0700 (PDT)
In-Reply-To: <4E0C68ED.1070506@digital-pipe.com>
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

On 06/30/2011 08:15 AM, David Henderson wrote:
> On 06/29/2011 09:57 AM, David Henderson wrote:
>> Hi gang!  I've successfully been able to compile the alsa-utils 
>> package with the 
>> "--with-alsa-inc-prefix=/opt/staging/alsa/var/share/include 
>> --with-alsa-prefix=/opt/staging/alsa/lib", but the problem I'm having 
>> now is that the compiled binaries are looking for those directories 
>> during run-time and not just compile-time.  Does anyone have any 
>> thoughts on using those directories for package creation, but that 
>> the software doesn't use the '/opt/staging/alsa' prefix during run-time?
>>
>> Thanks,
>> Dave
>
> bump for help

Maybe I'm asking the wrong questions :), so lets try this... what are 
the recommended steps to compile this software for package maintainers?

Thanks
Dave
