From: Ed Wildgoose <lists@wildgooses.com>
Subject: Re: Problem with RME 9632 and Plug
Date: Tue, 03 Aug 2004 17:21:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <410FBB6E.5010003@wildgooses.com>
References: <200408031436.i73EaLj2005332@localhost.localdomain> <410FB2EC.8010008@wildgooses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <410FB2EC.8010008@wildgooses.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, thomas@undata.org
List-Id: alsa-devel@alsa-project.org

Hmm, looking through the 9632 driver code I notice things like:

static snd_pcm_hardware_t snd_hdsp_playback_subinfo =
{
 ..snip ...
        .periods_min =          2,
        .periods_max =          2,


Hmm, oh dear.  Perhaps this driver only allows two periods...?  I could 
have sworn that I was using more than this before though..?  Is there 
any kind of fixup performed at the alsa level which emulates having more 
periods than this...?

Ed W




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
