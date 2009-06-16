From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Playback open error: Device or resource busy
Date: Tue, 16 Jun 2009 11:23:32 +0200
Message-ID: <4A376494.1080004@ladisch.de>
References: <4A36C12A.7070408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 1CC981037F4
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Jun 2009 11:23:39 +0200 (CEST)
In-Reply-To: <4A36C12A.7070408@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guilherme <grlongo.ireland@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Guilherme wrote:
> Playback device is plughw:0,0
> Playback open error: Device or resource busy

That program should use "default" instead of "plughw:0,0".


HTH
Clemens
