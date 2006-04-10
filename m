From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001981]: Compilation problem in pcm/pcm.c
Date: Mon, 10 Apr 2006 18:32:56 +0200
Message-ID: <f3b3606b9e28fbe1e73075ed7173439c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B239617C
	for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2006 18:32:56 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1981> 
======================================================================
Reported By:                croiset
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1981
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-31-2006 13:49 CEST
Last Modified:              04-10-2006 18:32 CEST
======================================================================
Summary:                    Compilation problem in pcm/pcm.c
Description: 
In the function snd_pcm_get_params, you must declare everything before
making any code. If it's not the case, it will create a compilation error
on C.

Before in line 7266 :
int snd_pcm_get_params(snd_pcm_t *pcm,
                       snd_pcm_uframes_t *buffer_size,
                       snd_pcm_uframes_t *period_size)
{
   assert(pcm);
   snd_pcm_hw_params_t *hw;
   int err;

   snd_pcm_hw_params_alloca(&hw);

After correction :
int snd_pcm_get_params(snd_pcm_t *pcm,
                       snd_pcm_uframes_t *buffer_size,
                       snd_pcm_uframes_t *period_size)
{
   snd_pcm_hw_params_t *hw;
   int err;

   assert(pcm);

   snd_pcm_hw_params_alloca(&hw);
======================================================================

----------------------------------------------------------------------
 tiwai - 04-10-06 18:32 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-06 13:49 croiset        New Issue                                    
04-10-06 18:32 tiwai          Status                   new => resolved     
04-10-06 18:32 tiwai          Resolution               open => fixed       
04-10-06 18:32 tiwai          Assigned To               => tiwai           
04-10-06 18:32 tiwai          Note Added: 0009212                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
