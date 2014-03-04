From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] Wrap hw_ptr to boundary in pcm_ioplug
Date: Tue, 04 Mar 2014 13:03:26 +0100
Message-ID: <5315C10E.2010502@perex.cz>
References: <67BA5DEFFBE7BF46B4C53F7E5FC5AD44344700ED7C@MXCL13.fgremc.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 67BD92656E9
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 13:03:27 +0100 (CET)
In-Reply-To: <67BA5DEFFBE7BF46B4C53F7E5FC5AD44344700ED7C@MXCL13.fgremc.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "MONTANARO Luciano (MM)" <luciano.montanaro@magnetimarelli.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Date 4.3.2014 12:51, MONTANARO Luciano (MM) wrote:
> The function snd_pcm_ioplug_hw_ptr_update() always increased the hw_ptr
> by delta, without wrapping it to the boundary. This would lead to
> problems when after many hours, the hw_ptr would overflow.

Applied to our GIT tree. Thanks.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
