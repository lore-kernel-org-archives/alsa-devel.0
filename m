From: Sayem Ahmed <sayem64@gmail.com>
Subject: Re: Opening a PCM device in shared mode
Date: Sat, 26 Nov 2011 22:31:11 +0600
Message-ID: <4ED1144F.8080100@gmail.com>
References: <4EC8C046.4030706@gmail.com>
	<C516192DA6D2B74F8192CDC209D958FD5834F34861@dr-mail>
	<4ECA31FA.60002@gmail.com>
	<3fd61e9d-1751-4294-b627-ea45fedd0d54@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3D5A2246AF
	for <alsa-devel@alsa-project.org>; Sat, 26 Nov 2011 17:31:18 +0100 (CET)
Received: by bkat8 with SMTP id t8so5138096bka.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Nov 2011 08:31:16 -0800 (PST)
In-Reply-To: <3fd61e9d-1751-4294-b627-ea45fedd0d54@email.android.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/24/2011 11:31 PM, Clemens Ladisch wrote:
> Is there a reason why your application needs to
> duplicate this?

Yes. Clients would like to install multiple sound cards into their 
system so that they can perform multiple VoIP calls at the same time. 
For each call a different sound card will be used. This is why I need 
this functionality in my application.
