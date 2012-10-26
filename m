From: "Bharath Ramachandramurthy" <bramacha@codeaurora.org>
Subject: Store codec capabilites in alsa
Date: Thu, 25 Oct 2012 19:07:07 -0700
Message-ID: <000001cdb31e$9a76a530$cf63ef90$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
 [199.106.114.254])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D9FE265092
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2012 04:07:11 +0200 (CEST)
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: bramacha@codeaurora.org
List-Id: alsa-devel@alsa-project.org

Hello

 

Is there a mechanism for the codec driver to register the codec
capabilities to the ALSA framework ? 

 

The BE CPU dai driver can then read the capabilities of the codec and talk
to the DSP. 

 

Thanks

Bharath

 
