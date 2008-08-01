From: "John L. Utz III" <john.utz@dmx.com>
Subject: Re: git clone alsa-driver behind a firewall?
Date: Fri, 01 Aug 2008 16:24:07 -0700
Message-ID: <op.ue8dyhu2647oa9@jutz-gnto64>
References: <op.ue79spew647oa9@jutz-gnto64>
	<489387FA.2080200@keyaccess.nl> <op.ue796w2d647oa9@jutz-gnto64>
	<op.ue8bo2d2647oa9@jutz-gnto64> <48939205.7090200@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 3400B245AF
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Aug 2008 01:24:30 +0200 (CEST)
In-Reply-To: <48939205.7090200@keyaccess.nl>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 01 Aug 2008 15:45:25 -0700, Rene Herman <rene.herman@keyaccess.nl>  
wrote:

> On 02-08-08 00:35, John L. Utz III wrote:
>
>> that works, it might be good to update the git page to list that  
>> mechanism more explicitly:
>>   git clone http://git.alsa-project.org/http/alsa-driver.git alsa-driver
>
> It's already at:
>
> http://www.alsa-project.org/main/index.php/GIT_Server
>
> The HTTP URL is fairly at the top and under "Occasional Developers" the  
> clone is spelled out (note though that if you can make requests of your  
> admin, native GIT protocol usage is better/more economic).

right, and this is a nit, but it's a worthwile nit because i had to ask,  
it should say:

   git clone http://git.alsa-project.org/http/alsa-driver.git alsa-driver

instead of just:

   http://git.alsa-project.org/http/alsa-driver.git alsa-driver

because it's inconsistent with how the 'proper' mechanism is listed on the  
website, worse yet, when you click on the url you get a perfectly  
reasonable web page that would lead you to conclude that http access is  
meant to be done 'by hand'.

not a big deal, but it seemed like a good UX/QA thing to mention...

tnx for your consideration in any case!

johnu

> Rene
>
