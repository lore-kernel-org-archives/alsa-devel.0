From: Sundance <sundance@ierne.eu.org>
Subject: Re: ALC Chips, now Realtek...
Date: Sun, 26 May 2002 15:37:03 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020526133703.1A30CAAC@byblos.ierne.eu.org>
References: <E17BvQU-0000bb-00@usw-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E17BvQU-0000bb-00@usw-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

From: Christoph Sassenberg <sassi@sforce.org>

> Question: Is anybody working on that ALC stuff?

Apparently not. However, according to the sources of the alsa-driver-0.5.11 
thing from Realtek, it is kind of 'standard' as far as AC97 (or AC'97, I 
don't know -- there seems to be a subtle difference) is concerned, from what 
I can tell, so patching the current AC97 sources to get it to work shouldn't 
be /too/ difficult. Provided that you know /what/ to patch exactly. Which I 
don't, unfortunately (if one of the admirable gurus here were kind enough as 
to point us developper wannabees to some crash course to chip sound 
programming and ALSA 0.9, maybe... :)).

However, given VIA's recent messages to the list, I'd say I'm confident that 
support for VIA's latest southbridges (VT8233A et al) and the underlying 
chips shouldn't be too much of a long-term problem. Stay put, stay confident! 
It's great to see companies open up to the open source development way of 
thinking.

BTW, are you sure that your motherboard's southbridge is really a VT8233, and 
not a VT8233A? I have a gut feeling (based on little to no factual evidence, 
note) that our problems with recent VIA-based motherboards lie with the 
southbridge (VT8233A) and not the underlying sound chip (ALC<whatever>). Just 
an idea anyway.

-- S.

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
