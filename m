From: Eran Guendelman <erang@stanford.edu>
Subject: Re: probing state of high definition audio card in
 windows / SigmaTel STAC9221 microphone problems
Date: Fri, 08 Jun 2007 15:40:19 -0700
Message-ID: <4669DAD3.3080301@stanford.edu>
References: <4669311C.6020800@stanford.edu>
	<75b66ecd0706081524v6242f1adw1038dc27d015ab4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from agp.stanford.edu (agp.Stanford.EDU [171.67.73.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C8F924487
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Jun 2007 00:40:21 +0200 (CEST)
In-Reply-To: <75b66ecd0706081524v6242f1adw1038dc27d015ab4d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On 6/8/07, Eran Guendelman <erang@stanford.edu> wrote:
>> So the question is, does anyone have a ready-made utility for Windows to
>> do this probe of the high definition audio codec?  I could probably try
>> writing one myself, but thought I'd check if it already exists.
> 
> I think it's just in the .inf file.
> 
> Lee
> 

I was able to find the default pin configurations in the .INI file, but 
have not yet understood what the rest of the stuff in the .INI file 
means (and I haven't really looked at any .INF files).  If you know of 
any guides to help understand the SigmaTel-codec related contents of an 
INI/INF file I would be happy to look at that.  I do see stuff like

[HKLM\SOFTWARE\SigmaTel\STSysTray\1.0\EventExpressions\JackPresensec]
Action1="if(JackState(10) == 0 && JackState(15) == 0 && JackState(12) == 
0 && GetPortPopup(12) == 1,(SetDeviceType(10,2)),(0))"
Action2="if(JackState(10) == 0 && JackState(15) == 0 && JackState(12) == 
0 && GetPortPopup(12) == 1,(SetDeviceType(15,2)),(0))"
Action3="if(JackState(10) == 0 && JackState(15) == 0 && JackState(12) == 
0 && GetPortPopup(12) == 1,(SetDeviceType(12,8)),(0))"

which could hold the key to what I'm looking for...

Thanks.
