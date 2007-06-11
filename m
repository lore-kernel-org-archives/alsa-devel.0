From: LCID Fire <lcid-fire@gmx.net>
Subject: Re: Quirks device not showing up
Date: Tue, 12 Jun 2007 00:38:37 +0200
Message-ID: <466DCEED.5020904@gmx.net>
References: <46506D9D.4000701@gmx.net>	
	<75b66ecd0705201225w5e6a7e28t7a61f000cd5e2352@mail.gmail.com>	
	<s5hk5v2p4az.wl%tiwai@suse.de> <46520655.7000402@gmx.net>	
	<4668715B.1020208@gmx.net> <466DBDB9.2080309@gmx.net>
	<75b66ecd0706111535j1750b17g732eb02346b61dd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 2A461103826
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2007 00:38:39 +0200 (CEST)
In-Reply-To: <75b66ecd0706111535j1750b17g732eb02346b61dd8@mail.gmail.com>
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

Lee Revell wrote:
> On 6/11/07, LCID Fire <lcid-fire@gmx.net> wrote:
>> I have to correct myself a bit. The patch is actually working - and my
>> card and it's channels are detected just fine - problem is there seems
>> to be no mixer available for my channels.
>> When I try to access my card using alsamixer I get a message "No mixer
>> elems found". Is there a special .conf file necessary and what's the
>> format for it?
> 
> This is normal, many USB devices don't have any mixer elements.
Ok, but isn't there a software way to emulate the mixer?
