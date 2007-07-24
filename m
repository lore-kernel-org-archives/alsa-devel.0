From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Query regarding ALSA control interface
Date: Tue, 24 Jul 2007 08:57:30 +0200
Message-ID: <1185260250.4021.1201714071@webmail.messagingengine.com>
References: <61445c750707231616s1936fda3p4fa0677cc187860c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 85DE8103812
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 08:57:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61445c750707231616s1936fda3p4fa0677cc187860c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> Now, I have to implement a control which takes four different values..namely
> 0,1.100 and 101. In this case what shoud be the type of control? It should
> be ENUMERATED or INTEGER? I am confused here since the values are not
> exactly in a range.

An INTEGER control takes numeric values in a specific range, while an
ENUMERATED control takes values that are not numerically related (but
that are _internally_ represented as integers in a specific range).

In your case, you'd probably want to use an enumerated control with the
range 0..3, which maps to the four names "0", "1", "100" and "101".


HTH
Clemens
