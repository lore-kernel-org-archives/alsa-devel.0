From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: RE: Sequencer events not arriving guaranteed
Date: Tue, 19 Feb 2002 09:38:20 +0100 (MET)
Message-ID: <XFMail.020219093820.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Received: from enterprise2.newlogic.com (enterprise2.newlogic.at [194.208.88.1])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA22494
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2002 09:38:53 +0100
Received: from enterprise2.newlogic.com (enterprise2 [172.27.1.1])
	by enterprise2.newlogic.com (8.9.2/8.9.2) with ESMTP id JAA15569
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2002 09:38:21 +0100 (MET)
In-Reply-To: <Pine.LNX.4.31.0202190933340.535-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thank you very much for your help, Jaroslav,
 I always appreciate your help


regards guenther

On 19-Feb-02 Jaroslav Kysela wrote:
> On Tue, 19 Feb 2002, Guenther Sohler wrote:
> 
>> Does that mean, i have to do following:
>>
>> 1.) open sequencer
>> 2.) create my own port on client
>> 3.) subscribe sender=my port receiver=midi device
>> 4.) create events set source to my client/port destination=midi device
>> 5.) send events
>>
>> is this the correct way of doing it ?
> 
> Yes, it is.
> 
>> are there some extra things, which are not neccessary ?
> 
> Nope.
> 
>                                               Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project  http://www.alsa-project.org
> SuSE Linux    http://www.suse.com
> 

Guenther Sohler

NewLogic Technologies AG 
Millennium Park 6
A-6890 Lustenau
                                           Phone: +43-5577-62000-507
E-Mail: guenther.sohler@newlogic.com       Fax:   +43-5577-62000-988


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
