From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Opening a PCM device in shared mode
Date: Sat, 26 Nov 2011 21:13:39 +0100
Message-ID: <4ED14873.7030006@ladisch.de>
References: <4EC8C046.4030706@gmail.com>
	<C516192DA6D2B74F8192CDC209D958FD5834F34861@dr-mail>
	<4ECA31FA.60002@gmail.com>
	<3fd61e9d-1751-4294-b627-ea45fedd0d54@email.android.com>
	<4ED1144F.8080100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id E5CE82470C
	for <alsa-devel@alsa-project.org>; Sat, 26 Nov 2011 21:13:54 +0100 (CET)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1AE5220793
	for <alsa-devel@alsa-project.org>; Sat, 26 Nov 2011 15:13:53 -0500 (EST)
In-Reply-To: <4ED1144F.8080100@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sayem Ahmed <sayem64@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sayem Ahmed wrote:
> On 11/24/2011 11:31 PM, Clemens Ladisch wrote:
> > Is there a reason why your application needs to
> > duplicate this?
>
> Yes. Clients would like to install multiple sound cards into
> their system so that they can perform multiple VoIP calls at
> the same time.

Use snd_card_next() to enumerate cards.
To open the default device of a specific card, try device name
"default:CARD=x", but this won't work if the user has redefined
the "default" device definition.


Regards,
Clemens
