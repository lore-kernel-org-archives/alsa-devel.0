From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: OSS support
Date: Wed, 17 Jun 2009 14:06:15 +0200
Message-ID: <20090617120615.GA403@tango.0pointer.de>
References: <4A38957C.5030905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 02E74103832
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Jun 2009 14:06:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A38957C.5030905@gmail.com>
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

On Wed, 17.06.09 11:04, The Source (thesourcehim@gmail.com) wrote:

> Is oss emulation still supported in latest alsa-driver snapshot? I 
> installed that driver in Fedora 11 on both my static machine (X-Fi 
> platinum fatality champion) and laptop (HDA Intel) and I don't have 
> /dev/dsp or /dev/mixer. Should I compile the driver with some specific flag?

OSS has long been obsolete. In F11 kernel OSS support is disabled by
default. You have to edit the modprobe blacklist to reenable it again.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
