From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: problem while reading the data from device(phone)
Date: Thu, 02 Aug 2007 09:57:13 +0200
Message-ID: <1186041433.9676.1203339279@webmail.messagingengine.com>
References: <000001c7d4b8$3d3baae0$9529320a@telxsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 2F43B103870
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Aug 2007 09:57:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <000001c7d4b8$3d3baae0$9529320a@telxsi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Susovan Ghosh <susovan@tataelxsi.co.in>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Susovan Ghosh wrote:
>        We are using ALSA for a application.We have a phone and RJ11 phone
> adaptor-duel.I connect the phone to PC through the adaptor amd use the ALSA
> function snd_pcm_readi() to capture what ever spoke in the phone.Adapter is
> a USB device.we mention "plughw:0,0" as a capture device.When we run the
> program we get an error "device is unavailable ".

What is the error message when you try to use arecord?


Regards,
Clemens
