From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ftp.alsa-project.org connection problems
Date: Thu, 28 Feb 2019 14:13:28 +0100
Message-ID: <4a373ffe-7a01-9e18-4513-7651f800a4db@perex.cz>
References: <20190225180431.GY6706@michaelspb>
 <f358a020-3166-ec1d-dd88-f08d8c5e6996@perex.cz>
 <20190225204347.GZ6706@michaelspb> <20190228115845.GB6706@michaelspb>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5BE07F89691
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2019 14:13:30 +0100 (CET)
In-Reply-To: <20190228115845.GB6706@michaelspb>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Michael Niedermayer <michael@niedermayer.cc>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 28. 02. 19 v 12:58 Michael Niedermayer napsal(a):
> On Mon, Feb 25, 2019 at 09:43:47PM +0100, Michael Niedermayer wrote:
>> On Mon, Feb 25, 2019 at 08:52:33PM +0100, Jaroslav Kysela wrote:
>>> Dne 25. 02. 19 v 19:04 Michael Niedermayer napsal(a):
>>>> Hi
>>>>
>>>> Iam not sure this is the correct place to report this to but i didnt see it
>>>> being reported anywhere yet on the ML archive or google
>>>
>>> ...
>>>
>>>> ==> PASV ... couldn't connect to 207.180.221.201 port 35333: No route to host
>>> Hi,
>>>
>>>   it seems that the ftp conntrack module was not loaded correctly after
>>> reboot, so the firewall blocks the passive connections. Could you give a
>>> try again?
>>
>> works fine locally
>>
>> Thanks!
> 
> Another related issue
> we tried to switch to https and that fails too with wget but works with browsers
> It appears this is due to a incomplete certificate chain
> 
> https://www.ssllabs.com/ssltest/analyze.html?d=www.alsa-project.org&hideResults=on
> "This server's certificate chain is incomplete. Grade capped to B."

Yep, you're right. The Let's Encrypt X3 CA certificate was missing in
the chain. Fixed now. We are in Grade A now.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
