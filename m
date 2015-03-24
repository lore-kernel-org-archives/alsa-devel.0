From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [TINYCOMPRESS][v2 PATCH 0/7] Convert build system
 to autotools
Date: Tue, 24 Mar 2015 16:46:31 +0000
Message-ID: <551194E7.9090800@imgtec.com>
References: <1427193154-6753-1-git-send-email-qais.yousef@imgtec.com>
 <20150324160754.GB32683@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CFED2604A1
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 17:46:37 +0100 (CET)
In-Reply-To: <20150324160754.GB32683@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/24/2015 04:07 PM, Vinod Koul wrote:
>
> 1. So after applying tha patches, I did ./autogen.sh, that seems to have
> updated INSTALL, do you know why?

Could you try removing --force from autoreconf args in autogen.sh and 
see if this fixes it? Maybe you have newer version than mine and that's 
why it tries to update it.
