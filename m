From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: CS4206 and S/PDIF (again)
Date: Wed, 2 Mar 2011 22:02:03 +0000
Message-ID: <C99419DF.3C4B%brian.austin@cirrus.com>
References: <1299102498-29063-1-git-send-email-arun.raghavan@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by alsa0.perex.cz (Postfix) with ESMTP id 4E44C10383E
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2011 23:04:16 +0100 (CET)
In-Reply-To: <1299102498-29063-1-git-send-email-arun.raghavan@collabora.co.uk>
Content-Language: en-US
Content-ID: <C848F0213A6646499168E41C3A6651C0@ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun.raghavan@collabora.co.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The verb sequence works for all 420x versions and has no impact on which
version it is applied to.

Brian

On 3/2/11 3:48 PM, "Arun Raghavan" <arun.raghavan@collabora.co.uk> wrote:

>I bisected this down to the erratum fix added in commit a769cbcf. From
>what I can tell, the erratum only applies to CS4207, so I'm attaching a
>patch to make the fix conditional. CC'ing the author of that commit to
>verify that this is correct.
>
>Cheers,
>Arun
>
>
